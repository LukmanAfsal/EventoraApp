import SwiftUI

struct TicketSelectionView: View {
    @Environment(\.dismiss) var dismiss
    let event: EvntoraEvent
    
    // State for selected options
    @State private var selectedDateIndex = 0
    @State private var ticketQuantities: [String: Int] = [:]
    @State private var showingCheckout = false
    
    // Sample data - replace with your actual data model
    let availableDates = ["Friday, March 8", "Saturday, March 9", "Sunday, March 10"]
    let ticketTypes = [
        TicketType(id: "general", name: "General Admission", price: 499, description: "Standard entry to the event", maxPerOrder: 6),
        TicketType(id: "vip", name: "VIP Experience", price: 1299, description: "Premium viewing area + exclusive lounge access", maxPerOrder: 4),
        TicketType(id: "earlybird", name: "Early Bird", price: 399, description: "Limited discounted tickets", maxPerOrder: 2)
    ]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Event header
                    HStack(alignment: .top) {
                        if let url = URL(string: event.image) {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .success(let image):
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(10)
                                default:
                                    Color.gray
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(10)
                                }
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(event.title)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                                .lineLimit(2)
                            
                            Text(event.location)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        .padding(.leading, 8)
                        
                        Spacer()
                    }
                    .padding(.bottom, 10)
                    
                    // Date selection
                    VStack(alignment: .leading, spacing: 12) {
                        Text("SELECT DATE")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.gray)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(0..<availableDates.count, id: \.self) { index in
                                    DateOptionView(
                                        date: availableDates[index],
                                        isSelected: index == selectedDateIndex
                                    ) {
                                        withAnimation {
                                            selectedDateIndex = index
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    // Ticket types
                    VStack(alignment: .leading, spacing: 12) {
                        Text("TICKET TYPES")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.gray)
                        
                        ForEach(ticketTypes) { ticket in
                            TicketTypeCard(
                                ticket: ticket,
                                quantity: ticketQuantities[ticket.id] ?? 0,
                                onIncrement: {
                                    if (ticketQuantities[ticket.id] ?? 0) < ticket.maxPerOrder {
                                        ticketQuantities[ticket.id] = (ticketQuantities[ticket.id] ?? 0) + 1
                                    }
                                },
                                onDecrement: {
                                    if (ticketQuantities[ticket.id] ?? 0) > 0 {
                                        ticketQuantities[ticket.id] = (ticketQuantities[ticket.id] ?? 0) - 1
                                    }
                                }
                            )
                        }
                    }
                    
                    // Pricing summary
                    VStack(spacing: 12) {
                        HStack {
                            Text("Subtotal")
                                .foregroundColor(.gray)
                            Spacer()
                            Text("₹\(calculateSubtotal())")
                                .foregroundColor(.white)
                        }
                        
                        HStack {
                            Text("Fees")
                                .foregroundColor(.gray)
                            Spacer()
                            Text("₹49")
                                .foregroundColor(.white)
                        }
                        
                        Divider()
                            .background(Color.gray.opacity(0.5))
                        
                        HStack {
                            Text("Total")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                            Spacer()
                            Text("₹\(calculateTotal())")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.top, 20)
                    
                    Spacer().frame(height: 80)
                }
                .padding()
            }
            
            // Bottom action bar
            VStack {
                Spacer()
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(totalTicketsSelected()) tickets")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .bold))
                        
                        Text("₹\(calculateTotal())")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .bold))
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        showingCheckout = true
                    }) {
                        Text("Continue")
                            .frame(width: 180, height: 50)
                            .background(totalTicketsSelected() > 0 ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))
                            .cornerRadius(10)
                    }
                    .disabled(totalTicketsSelected() == 0)
                }
                .padding()
                .background(Material.ultraThinMaterial)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Select Tickets")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .bold))
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Material.regularMaterial, for: .navigationBar)
        .toolbarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingCheckout) {
            CheckoutView(ticketPrice: 199.00, seatCount: 10)
        }
    }
    
    private func calculateSubtotal() -> Int {
        var subtotal = 0
        for (ticketId, quantity) in ticketQuantities {
            if let ticket = ticketTypes.first(where: { $0.id == ticketId }) {
                subtotal += ticket.price * quantity
            }
        }
        return subtotal
    }
    
    private func calculateTotal() -> Int {
        return calculateSubtotal() + 49 // Adding fixed fee for example
    }
    
    private func totalTicketsSelected() -> Int {
        return ticketQuantities.values.reduce(0, +)
    }
}

// MARK: - Subviews

struct DateOptionView: View {
    let date: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Text(date.components(separatedBy: ", ").first ?? "")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(isSelected ? .white : .gray)
                
                Text(date.components(separatedBy: ", ").last ?? "")
                    .font(.system(size: 12))
                    .foregroundColor(isSelected ? .white : .gray)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(isSelected ? Color.blue : Color("cgray"))
            .cornerRadius(10)
        }
    }
}

struct TicketTypeCard: View {
    let ticket: TicketType
    let quantity: Int
    let onIncrement: () -> Void
    let onDecrement: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(ticket.name)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("₹\(ticket.price)")
                        .font(.system(size: 14))
                        .foregroundColor(.blue)
                    
                    Text(ticket.description)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
                
                // Quantity selector
                HStack(spacing: 0) {
                    Button(action: onDecrement) {
                        Image(systemName: "minus")
                            .foregroundColor(quantity > 0 ? .white : .gray)
                            .frame(width: 40, height: 40)
                            .background(quantity > 0 ? Color.blue.opacity(0.8) : Color.gray.opacity(0.2))
                    }
                    .disabled(quantity == 0)
                    
                    Text("\(quantity)")
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .background(Color("cgray"))
                    
                    Button(action: onIncrement) {
                        Image(systemName: "plus")
                            .foregroundColor(quantity < ticket.maxPerOrder ? .white : .gray)
                            .frame(width: 40, height: 40)
                            .background(quantity < ticket.maxPerOrder ? Color.blue.opacity(0.8) : Color.gray.opacity(0.2))
                    }
                    .disabled(quantity >= ticket.maxPerOrder)
                }
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                )
            }
            
            if quantity > 0 {
                HStack {
                    Spacer()
                    Text("₹\(ticket.price * quantity)")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                }
            }
        }
        .padding()
        .background(Color("cgray"))
        .cornerRadius(12)
    }
}

// MARK: - Data Models

struct TicketType: Identifiable {
    let id: String
    let name: String
    let price: Int
    let description: String
    let maxPerOrder: Int
}

// MARK: - Preview

#Preview {
    NavigationStack {
        let sampleEvent = EvntoraEvent(
            id: "1",
            image: "https://s3.ap-south-1.amazonaws.com/media.thesouthfirst.com/wp-content/uploads/2025/02/Officer-on-Duty.jpg",
            title: "Sample Event",
            date: "Friday, March 8",
            location: "Sample Venue, City",
            gatesOpenTime: "6:00 PM",
            time: "7:30 PM",
            price: 499,
            distance: "5 km away",
            description: "This is a sample event description. Join us for an amazing experience!",
            artist: Artist(name: "Sample Artist", image: "https://assetscdn1.paytm.com/images/cinema/Kunchacko-Boban-ed0ea550-9185-11eb-b324-e3ae738e1ebb.jpg?format=webp&imwidth=64"), seatingType: 2
        )
        
        TicketSelectionView(event: sampleEvent)
    }
}
