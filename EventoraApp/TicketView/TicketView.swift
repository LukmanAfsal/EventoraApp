//
//  TicketView.swift
//  EventoraApp
//
//  Created by Abhinand K J on 27/03/25.
//

import SwiftUI

struct EventTicketView: View {
    let event: EvntoraEvent
    let bookingDetails: BookingDetails
    
    var body: some View {
        ZStack {
            // Background with decorative elements
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Ticket header with event image
                ZStack(alignment: .topLeading) {
                    if let url = URL(string: event.image) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 180)
                                    .clipped()
                            default:
                                Color.gray
                                    .frame(height: 180)
                            }
                        }
                    }
                    
                    // Event title overlay
                    VStack {
                        Spacer()
                        HStack {
                            Text(event.title)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 5)
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                    }
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.clear, .black.opacity(0.7)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                }
                .frame(height: 180)
                
                // Ticket details section
                VStack(spacing: 20) {
                    // Event details
                    VStack(spacing: 12) {
                        DetailRow(icon: "calendar", text: event.date)
                        DetailRow(icon: "clock", text: "Gates open at \(event.gatesOpenTime)")
                        DetailRow(icon: "mappin.and.ellipse", text: event.location)
                    }
                    .padding(.top, 20)
                    
                    // Booking details
                    VStack(spacing: 12) {
                        DetailRow(icon: "ticket", text: "Ticket Type: \(bookingDetails.ticketType)")
                        DetailRow(icon: "person.2", text: "Quantity: \(bookingDetails.quantity)")
                        DetailRow(icon: "barcode", text: "Order #: \(bookingDetails.orderNumber)")
                    }
                    
                    // QR Code
                    VStack(spacing: 8) {
                        Text("Scan QR at entry")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.gray)
                        
                        Image(uiImage: generateQRCode(from: bookingDetails.qrCodeData))
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(8)
                        
                        Text(bookingDetails.qrCodeData)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 20)
                    
                    // Terms and conditions
                    Text("Present this ticket at the venue. Valid only for the specified date and time. No refunds or exchanges.")
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                }
                .padding(.horizontal, 20)
                .background(Color("cgray"))
                
                // Perforation line at bottom
                HStack(spacing: 4) {
                    ForEach(0..<20, id: \.self) { _ in
                        Circle()
                            .frame(width: 4, height: 4)
                            .foregroundColor(.gray.opacity(0.5))
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 10)
            }
        }
        
        .navigationTitle("Your Ticket")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // Share action
                    shareTicket()
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.blue)
                }
            }
        }
    }
    
    // Generate QR code from string
    private func generateQRCode(from string: String) -> UIImage {
        let context = CIContext()
        let filter = CIFilter(name: "CIQRCodeGenerator")!
        
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("H", forKey: "inputCorrectionLevel") // Error correction level
        
        if let outputImage = filter.outputImage {
            let scaledImage = outputImage.transformed(by: CGAffineTransform(scaleX: 10, y: 10))
            if let cgimg = context.createCGImage(scaledImage, from: scaledImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    // Share ticket function
    private func shareTicket() {
        let renderer = ImageRenderer(content: self.body)
        if let image = renderer.uiImage {
            let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
        }
        
    }
    
}

struct DetailRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 20)
            
            Text(text)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
            
            Spacer()
        }
    }
}

struct BookingDetails {
    let ticketType: String
    let quantity: Int
    let orderNumber: String
    let qrCodeData: String
    let bookingDate: Date
}

// Preview
#Preview {
    NavigationStack {
        let sampleEvent = EvntoraEvent(
            id: "1",
            image: "https://s3.ap-south-1.amazonaws.com/media.thesouthfirst.com/wp-content/uploads/2025/02/Officer-on-Duty.jpg",
            title: "Tech Conference 2025",
            date: "Friday, March 8, 2025",
            location: "Koratty Infopark, Thrissur, Kerala",
            gatesOpenTime: "6:00 PM",
            time: "7:30 PM",
            price: 499,
            distance: "5 km away",
            description: "Annual technology conference featuring industry leaders and workshops.",
            artist: Artist(name: "Tech Leaders", image: ""), seatingType: 1
        )
        
        let bookingDetails = BookingDetails(
            ticketType: "General Admission",
            quantity: 2,
            orderNumber: "EV-2025-876543",
            qrCodeData: "EVENTORA-\(sampleEvent.id)-\(UUID().uuidString)",
            bookingDate: Date()
        )
        
        EventTicketView(event: sampleEvent, bookingDetails: bookingDetails)
    }
}
