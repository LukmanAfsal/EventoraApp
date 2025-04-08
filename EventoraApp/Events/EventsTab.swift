//
//  EventsTab.swift
//  EventoraApp
//
//  Created by Abhinand K J on 20/02/25.
//

import SwiftUI


struct EventsTab: View {
    @State private var currentIndex = 0
    @State private var displayIndex = 0
    @State private var selectedCategory = "Music"
    
    let categories = ["Music", "Comedy", "Theatre & Performing Arts", "Festival", "Celebrity & Influencer Events", "Nightlife & Clubbing"]
    
    let events = [
        Event(title: "M.M. Keeravani Live in Concert | Hyderabad", date: "22 Mar, 7PM", location: "Hyderabad", image: "e2"),
        Event(title: "Sample Event 2", date: "25 Mar, 8PM", location: "Mumbai", image: "e2"),
        Event(title: "Sample Event 3", date: "30 Mar, 6PM", location: "Delhi", image: "e3"),
        Event(title: "Sample Event 4", date: "5 Apr, 9PM", location: "Bangalore", image: "e4"),
        Event(title: "Sample Event 5", date: "10 Apr, 7PM", location: "Chennai", image: "e4")
    ]
    
    let artists = [
        (name: "Prateek Kuhad", image: "e2"),
        (name: "Geetha Madhuri", image: "e3"),
        (name: "M.M. Keeravani", image: "e4"),
        (name: "Rishi Rikhiram", image: "e2")
    ]
    
    let concerts = [
        ConcertEvent(
            artistName: "Prateek Kuhad",
            eventTitle: "Prateek Kuhad live at Quake Arena",
            venue: "Quake Arena",
            city: "Hyderabad",
            price: "₹999 onwards",
            posterImageName: "e1",
            date: createDate(day: 22, month: 3, year: 2025)
        ),
        ConcertEvent(
            artistName: "Geetha Madhuri",
            eventTitle: "Geetha Madhuri Concert",
            venue: "Phoenix Arena",
            city: "Bengaluru",
            price: "₹1299 onwards",
            posterImageName: "e3",
            date: createDate(day: 15, month: 4, year: 2025)
        ),
        ConcertEvent(
            artistName: "M.M. Keeravani",
            eventTitle: "Musical Night with M.M. Keeravani",
            venue: "Shilpakala Vedika",
            city: "Hyderabad",
            price: "₹1499 onwards",
            posterImageName: "e4",
            date: createDate(day: 5, month: 5, year: 2025)
        ),
        ConcertEvent(
            artistName: "Rishi Rikhiram",
            eventTitle: "Rishi Rikhiram Live",
            venue: "Hard Rock Cafe",
            city: "Mumbai",
            price: "₹899 onwards",
            posterImageName: "e3",
            date: createDate(day: 28, month: 3, year: 2025)
        )
    ]
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            ScrollView {
                LazyVStack(spacing: 20) {
                    // Featured Events Section
                    VStack(spacing: 0) {
                        GradientLine(title: "FEATURED EVENTS")
                            .padding(.horizontal, 16)
                        
                        ZStack(alignment: .bottom) {
                            let displayEvents = events + [events[0]]
                            
                            TabView(selection: $displayIndex) {
                                ForEach(0..<displayEvents.count, id: \.self) { index in
                                    GeometryReader { geometry in
                                        let minX = geometry.frame(in: .global).minX
                                        let rotationAngle = minX / 10
                                        
                                        EventCard(event: displayEvents[index])
                                            .rotation3DEffect(
                                                Angle(degrees: -rotationAngle),
                                                axis: (x: 0, y: 1, z: 0)
                                            )
                                            .scaleEffect(1 - abs(minX) / 1000)
                                            .tag(index)
                                    }
                                    .frame(height: 500)
                                }
                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            .frame(height: 500)
                            .onChange(of: displayIndex) { oldValue, newValue in
                                if newValue == events.count {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        withAnimation(nil) {
                                            displayIndex = 0
                                        }
                                    }
                                }
                                
                                currentIndex = min(newValue, events.count - 1)
                            }
                            
                            // Page Indicators
                            HStack(spacing: 8) {
                                ForEach(0..<events.count, id: \.self) { index in
                                    Circle()
                                        .fill(currentIndex == index ? Color.white : Color.gray.opacity(0.5))
                                        .frame(width: 8, height: 8)
                                }
                            }
                            .padding(.bottom, 16)
                        }
                    }
                    
                    // Category Section
                    VStack(spacing: 0) {
                        GradientLine(title: "CATEGORIES")
                            .padding(.horizontal, 16)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(categories, id: \.self) { category in
                                    CategoryButton(
                                        title: category,
                                        isSelected: selectedCategory == category,
                                        action: {
                                            withAnimation {
                                                selectedCategory = category
                                            }
                                        }
                                    )
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                        }
                    }
                    
                    // Artists Section
                    VStack(spacing: 0) {
                        GradientLine(title: "ARTISTS")
                            .padding(.horizontal, 16)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                ForEach(artists, id: \.name) { artist in
                                    ArtistView(name: artist.name, imageName: artist.image)
                                        .padding(.leading, 16)
                                }
                            }
                            .padding(.trailing, 16)
                        }
                        .padding(.vertical, 12)
                    }
                    
                    // All Events Section
                    VStack(spacing: 0) {
                        GradientLine(title: "ALL EVENTS")
                            .padding(.horizontal, 16)
                        
                        LazyVStack(spacing: 24) {
                            ForEach(concerts, id: \.id) { concert in
                                ConcertCardView(concert: concert)
                                    .padding(.horizontal, 16)
                            }
                        }
                        .padding(.vertical, 20)
                    }
                }
                .padding(.vertical, 16)
            }
        }
    }
}

// Model for concert data
struct ConcertEvent {
    let id = UUID()
    let artistName: String
    let eventTitle: String
    let venue: String
    let city: String
    let price: String
    let posterImageName: String
    let date: Date
}

// Formatter for displaying dates
extension ConcertEvent {
    var dayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }
    
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: date)
    }
    
    var monthString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: date)
    }
}

struct ConcertCardView: View {
    let concert: ConcertEvent
    
    var body: some View {
        VStack(spacing: 0) {
            // Poster image (complete as-is)
            Image(concert.posterImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(24, corners: [.topLeft, .topRight])
            
            // Event details section
            HStack(alignment: .top, spacing: 16) {
                // Date box
                VStack(spacing: 0) {
                    Text(concert.dayString)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 10)
                    
                    Text(concert.dateString)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.vertical, 4)
                    
                    Text(concert.monthString)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 10)
                }
                .frame(width: 70)
                .background(Color(white: 0.15))
                .cornerRadius(12)
                
                // Event details
                VStack(alignment: .leading, spacing: 6) {
                    Text(concert.eventTitle)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .lineLimit(1)
                    
                    Text("\(concert.venue), \(concert.city)")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .lineLimit(1)
                    
                    Text(concert.price)
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .padding(.top, 2)
                }
                .padding(.vertical, 10)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(Color.black)
            .cornerRadius(24, corners: [.bottomLeft, .bottomRight])
        }
        .background(Color.black)
        .cornerRadius(24)
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}

// Extension for custom corner radius
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// Helper function to create dates
func createDate(day: Int, month: Int, year: Int) -> Date {
    var components = DateComponents()
    components.day = day
    components.month = month
    components.year = year
    return Calendar.current.date(from: components) ?? Date()
}

struct ArtistView: View {
    let name: String
    let imageName: String
    
    var body: some View {
        VStack(alignment: .center) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                
            Text(name)
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .medium))
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(height: 50)
                .padding()
        }
        .frame(width: 120)
        .padding(.horizontal, 10)
    }
}

// Category Button Component
struct CategoryButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: isSelected ? .bold : .medium))
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            isSelected
                            ? AnyShapeStyle(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.purple, Color.blue]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                              )
                            : AnyShapeStyle(Color.purple.opacity(0.3))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder(
                                    isSelected
                                    ? Color.clear
                                    : Color.gray.opacity(0.5),
                                    lineWidth: 1
                                )
                        )
                )
                .shadow(
                    color: isSelected ? Color.purple.opacity(0.4) : Color.clear,
                    radius: isSelected ? 4 : 0,
                    x: 0,
                    y: isSelected ? 2 : 0
                )
                .foregroundColor(isSelected ? .white : .gray)
                .animation(.easeInOut(duration: 0.2), value: isSelected)
        }
        .scaleEffect(isSelected ? 1.05 : 1.0)
    }
}


// Event model
struct Event {
    let title: String
    let date: String
    let location: String
    let image: String
}

// Event card view
struct EventCard: View {
    let event: Event
    @State private var isMuted = true
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Event image
            Image(event.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width - 40, height: 450)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.clear, .cpurple.opacity(0.7)]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                )
            
            // Mute button
            Button(action: {
                isMuted.toggle()
            }) {
                Circle()
                    .fill(Color.black.opacity(0.5))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                            .foregroundColor(.white)
                    )
            }
            .padding(16)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            
            // Event info
            VStack(alignment: .leading, spacing: 8) {
                Text(event.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                
                Text("\(event.date) | \(event.location)")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                    .bold()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 36)
        }
        .frame(width: UIScreen.main.bounds.width - 40, height: 450)
    }
}

#Preview {
    EventsTab()
}
