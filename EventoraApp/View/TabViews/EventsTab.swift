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
    @State private var selectedCategory = "Music" // To track the selected category
    
    let categories = ["Music", "Comedy", "Theatre & Performing Arts", "Festival", "Celebrity & Influencer Events", "Nightlife & Clubbing"]
    
    let events = [
        Event(title: "M.M. Keeravani Live in Concert | Hyderabad", date: "22 Mar, 7PM", location: "Hyderabad", image: "e2"),
        Event(title: "Sample Event 2", date: "25 Mar, 8PM", location: "Mumbai", image: "e2"),
        Event(title: "Sample Event 3", date: "30 Mar, 6PM", location: "Delhi", image: "e3"),
        Event(title: "Sample Event 4", date: "5 Apr, 9PM", location: "Bangalore", image: "e4"),
        Event(title: "Sample Event 5", date: "10 Apr, 7PM", location: "Chennai", image: "e4")
    ]
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            ScrollView {
                LazyVStack(spacing: 20) {
                    GradientLine(title: "FEATURED EVENTS")
                    
                    ZStack(alignment: .bottom) {
                        let displayEvents = events + [events[0]]
                        
                        TabView(selection: $displayIndex) {
                            ForEach(0..<displayEvents.count, id: \.self) { index in
                                EventCard(event: displayEvents[index])
                                    .tag(index)
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
                        
                        HStack(spacing: 8) {
                            ForEach(0..<events.count, id: \.self) { index in
                                Circle()
                                    .fill(currentIndex == index ? Color.white : Color.gray.opacity(0.5))
                                    .frame(width: 8, height: 8)
                            }
                        }
//                        .padding(.bottom, 16)
                    }
                    
                    // Category ScrollView
                    VStack(alignment: .leading) {
                        
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
                            .padding(.horizontal, 8)
                            .padding(.bottom, 12)
                        }
                    }
                    
                }
                .padding()
            }
        }
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
                            : AnyShapeStyle(Color.black.opacity(0.3))
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
                                gradient: Gradient(colors: [.clear, .black.opacity(0.7)]),
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
