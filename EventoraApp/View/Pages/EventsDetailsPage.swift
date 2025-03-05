//
//  EventsDetailsPage.swift
//  EventoraApp
//
//  Created by Abhinand K J on 04/03/25.
//

import SwiftUI

// MARK: - Screen Dimensions
let screenHeight = UIScreen.main.bounds.height
let screenWidth = UIScreen.main.bounds.width

// MARK: - EventDetailsPage View
struct EventDetailsPage: View {
    // MARK: - State
    @State private var isExpanded = false
    
    // MARK: - Environment
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Properties
    let event: EvntoraEvent
    
    var body: some View {
        ZStack(alignment: .top) {
            // MARK: - Background
            Color.black.ignoresSafeArea()
            
            // MARK: - Scrollable Content
            ScrollView {
                Spacer().frame(height: 110)
                
                VStack(spacing: 20) {
                    // MARK: - Event Image
                    if let url = URL(string: event.image) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 360, height: 460)
                                    .cornerRadius(15)
                            case .failure:
                                Color.red
                                    .frame(width: 360, height: 460)
                                    .cornerRadius(15)
                            @unknown default:
                                Color.gray
                                    .frame(width: 360, height: 460)
                                    .cornerRadius(15)
                            }
                        }
                    } else {
                        Color.gray
                            .frame(width: 360, height: 460)
                            .cornerRadius(15)
                    }
                    
                    // MARK: - Event Title
                    Text(event.title)
                        .fontWeight(.bold)
                        .lineLimit(2)
                        .foregroundStyle(.white)
                        .font(.system(size: 25))
                    
                    // MARK: - Event Details Card
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color("cgray"))
                            .frame(width: 390)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            // Date and Time
                            HStack {
                                Image(systemName: "calendar.badge.clock")
                                    .foregroundStyle(.gray)
                                    .font(.system(size: 25))
                                    .padding(.trailing, 8)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack {
                                        let dateParts = event.date.components(separatedBy: ", ")
                                        let dateText = dateParts.count == 2 ? "\(dateParts[0].capitalized), \(dateParts[1])" : event.date
                                        
                                        Text(dateText)
                                        Text("|")
                                        Text("\(event.time) onwards")
                                    }
                                    .foregroundStyle(.white)
                                    .bold()
                                    
                                    Text("Gates open at \(event.gatesOpenTime)")
                                        .foregroundStyle(.gray)
                                        .bold()
                                        .font(.system(size: 15))
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Divider()
                                .background(Color.gray)
                            
                            // Location
                            HStack {
                                Image(systemName: "location.north")
                                    .foregroundStyle(.gray)
                                    .font(.system(size: 25))
                                    .padding(.trailing, 8)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(event.location)
                                        .foregroundStyle(.white)
                                        .bold()
                                    
                                    Text(event.distance)
                                        .foregroundStyle(.gray)
                                        .bold()
                                        .font(.system(size: 15))
                                }
                                Spacer()
                                
                                Button(action: {}) {
                                    Image(systemName: "arrow.turn.up.right")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 20))
                                        .padding(.leading, 13)
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .frame(width: 390)
                    
                    // MARK: - About Section
                    VStack(alignment: .leading) {
                        HStack {
                            Text("About")
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .font(.system(size: 25))
                                .padding(5)
                            
                            Spacer()
                        }
                        
                        Text(event.description)
                            .foregroundStyle(.gray)
                            .lineLimit(isExpanded ? nil : 4)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(5)
                        
                        Button(action: {
                            withAnimation {
                                isExpanded.toggle()
                            }
                        }) {
                            Text(isExpanded ? "Read less" : "Read more")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                                .padding(5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .underline()
                        }
                    }
                    .padding(1)
                    
                    // MARK: - Artist Section
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Artist")
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .font(.system(size: 25))
                                .padding(5)
                            
                            Spacer()
                        }
                        
                        HStack {
                            if let url = URL(string: event.artist.image) {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image.resizable()
                                            .scaledToFit()
                                            .frame(width: 120, height: 120)
                                            .clipShape(Circle())
                                    case .failure:
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 120, height: 120)
                                            .foregroundColor(.gray)
                                    @unknown default:
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 120, height: 120)
                                            .foregroundColor(.gray)
                                    }
                                }
                            } else {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 120)
                                    .foregroundColor(.gray)
                            }
                            
                            Text(event.artist.name)
                                .foregroundStyle(.white)
                                .bold()
                        }
                    }
                    .padding(1)
                }
                .padding()
                
                Spacer().frame(height: 110)
            }
            .ignoresSafeArea()
            
            // MARK: - Top Navigation Bar
            VStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundStyle(.white)
                            .font(.system(size: 24))
                    }
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundStyle(.white)
                            .font(.system(size: 21))
                    }
                }
                .padding()
                .background(
                    BlurView(style: .dark)
                        .ignoresSafeArea()
                )
            }
            
            // MARK: - Bottom Booking Bar
            VStack {
                Spacer()
                
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Starts From")
                            .foregroundStyle(.gray)
                            .bold()
                            .font(.system(size: 16))
                        
                        HStack(spacing: 2) {
                            Image(systemName: "indianrupeesign")
                                .foregroundStyle(.white)
                                .bold()
                                .font(.system(size: 17))
                            Text("\(event.price)")
                                .foregroundStyle(.white)
                                .bold()
                                .font(.system(size: 20))
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Text("Book tickets")
                            .padding()
                            .bold()
                            .foregroundColor(.black)
                            .background(.white)
                            .cornerRadius(10)
                            .frame(width: 140)
                    }
                    .shadow(color: .green, radius: 5, y: 2)
                }
                .padding(25)
                .background(
                    BlurView(style: .dark)
                        .ignoresSafeArea()
                )
            }
        }
        .navigationBarHidden(true)
    }
}


// MARK: - Preview
#Preview {
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
        artist: Artist(name: "Sample Artist", image: "https://assetscdn1.paytm.com/images/cinema/Kunchacko-Boban-ed0ea550-9185-11eb-b324-e3ae738e1ebb.jpg?format=webp&imwidth=64")
    )
    
    return EventDetailsPage(event: sampleEvent)
}
