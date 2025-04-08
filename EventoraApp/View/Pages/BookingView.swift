//
//  BookingView.swift
//  EventoraApp
//
//  Created by jeboy on 26/03/25.
//

import SwiftUI

struct BookingView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedSeats: Set<Int> = []
    @State private var scale: CGFloat = 1.0
    @State private var lastScaleValue: CGFloat = 1.0
    @State private var navigateToCheckout = false
    
    // Pricing for different seat sections
    let seatPrices: [SeatSection: Double] = [
        .front: 12.99,
        .middle: 15.99,
        .back: 19.99
    ]
    
    let columns = Array(repeating: GridItem(.fixed(40), spacing: 10), count: 8)
    
    // Calculate total price based on selected seats and their sections
    var totalPrice: Double {
        selectedSeats.reduce(0.0) { total, seatIndex in
            total + priceForSeat(seatIndex)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Curved Stage Indicator
                GeometryReader { geometry in
                    Path { path in
                        let width = geometry.size.width
                        let height = 30.0
                        
                        path.move(to: CGPoint(x: 0, y: height))
                        
                        // Create a curved line with control points
                        path.addCurve(
                            to: CGPoint(x: width, y: height),
                            control1: CGPoint(x: width * 0.25, y: height * 0.5),
                            control2: CGPoint(x: width * 0.75, y: height * 0.5)
                        )
                    }
                    .stroke(Color.white.opacity(0.5), lineWidth: 2)
                    .shadow(color: .yellow.opacity(0.3), radius: 5, x: 0, y: 2)
                }
                .frame(height: 40)
                .padding(.horizontal)
                
                Text("S T A G E")
                    .font(.caption)
                    .kerning(3)
                    .foregroundColor(.white.opacity(0.8))
                
                // Zoomable Seat Grid
                ScrollView([.horizontal, .vertical], showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(0..<64, id: \.self) { index in
                            SeatView(
                                seatNumber: index + 1,
                                isSelected: selectedSeats.contains(index),
                                section: getSeatSection(index),
                                price: priceForSeat(index)
                            )
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                toggleSeatSelection(index)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .scaleEffect(scale)
                    .frame(
                        width: UIScreen.main.bounds.width * 2,
                        height: UIScreen.main.bounds.height * 1.5
                    )
                }
                .gesture(
                    MagnificationGesture()
                        .onChanged { state in
                            let delta = state / lastScaleValue
                            scale *= delta
                            lastScaleValue = state
                            scale = scale.clamped(to: 0.5...3.0)
                        }
                        .onEnded { _ in
                            lastScaleValue = 1.0
                        }
                )
                .background(Color.black)
                
                // Booking Summary
                VStack(spacing: 15) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Selected Seats")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("\(selectedSeats.count) seats")
                                .font(.title3)
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("Total Price")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text(totalPrice, format: .currency(code: "USD"))
                                .font(.title3)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal)
                    
                    if !selectedSeats.isEmpty {
                        NavigationLink(destination: CheckoutView(ticketPrice: totalPrice, seatCount: selectedSeats.count), isActive: $navigateToCheckout) {
                            EmptyView()
                        }
                        
                        Button(action: {
                            navigateToCheckout = true
                        }) {
                            HStack {
                                Text("Confirm Booking")
                                Image(systemName: "checkmark.circle.fill")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .cornerRadius(15)
                        }
                        .padding()
                        .transition(.opacity)
                    }
                }
                .background(Color.black)
                .animation(.easeInOut, value: selectedSeats)
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Avengers: Endgame")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
            }
            .toolbarBackground(Color.black, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // Enum to represent seat sections
    enum SeatSection {
        case front, middle, back
    }
    
    // Determine the section for a given seat
    private func getSeatSection(_ index: Int) -> SeatSection {
        let totalSeats = 64
        let sectionSize = totalSeats / 3
        
        if index / 8 < sectionSize / 8 {
            return .front
        } else if index / 8 < (sectionSize * 2) / 8 {
            return .middle
        } else {
            return .back
        }
    }
    
    // Get price for a specific seat based on its section
    private func priceForSeat(_ index: Int) -> Double {
        let section = getSeatSection(index)
        return seatPrices[section] ?? 12.99
    }
    
    private func toggleSeatSelection(_ index: Int) {
        withAnimation(.spring()) {
            if selectedSeats.contains(index) {
                selectedSeats.remove(index)
            } else {
                selectedSeats.insert(index)
            }
        }
    }
}

struct SeatView: View {
    let seatNumber: Int
    var isSelected: Bool
    let section: BookingView.SeatSection
    let price: Double
    
    var body: some View {
        ZStack {
            // Different background color for each section
            RoundedRectangle(cornerRadius: 8)
                .fill(sectionColor)
                .opacity(isSelected ? 1.0 : 0.3)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(sectionColor, lineWidth: 1)
                )
            
            VStack {
                Text("\(seatNumber)")
                    .font(.system(size: 8))
                    .foregroundColor(isSelected ? .white : .gray)
                
                Text("$\(price, specifier: "%.2f")")
                    .font(.system(size: 8))
                    .foregroundColor(isSelected ? .white : .gray)
            }
        }
        .frame(width: 40, height: 40)
    }
    
    // Color based on seat section
    private var sectionColor: Color {
        switch section {
        case .front: return .green
        case .middle: return .blue
        case .back: return .red
        }
    }
}

extension CGFloat {
    func clamped(to range: ClosedRange<CGFloat>) -> CGFloat {
        Swift.min(Swift.max(self, range.lowerBound), range.upperBound)
    }
}

#Preview {
    BookingView()
}
