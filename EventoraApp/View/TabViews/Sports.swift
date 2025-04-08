//
//  DiningTab.swift
//  EventoraApp
//
//  Created by Abhinand K J on 20/02/25.
//

import SwiftUI

struct Sports: View {
    @State private var selectedFilter: String? = "Today"
    let timeFilters = ["Today", "Tomorrow", "This Weekend", "Screening"]
    
    // Sample data for events - more reusable approach
    let events: [EventModel] = [
        EventModel(
            id: 1,
            imageUrl: "e1",
            date: (day: "Sun", date: "23", month: "Mar"),
            title: "TATA IPL 2025 - Match 01",
            teams: "Sunrisers Hyderabad vs Rajasthan Royals",
            venue: "Rajiv Gandhi International Cricket Stadium, Hyderabad",
            price: "₹2750 onwards"
        ),
        EventModel(
            id: 2,
            imageUrl: "e2",
            date: (day: "Mon", date: "24", month: "Mar"),
            title: "TATA IPL 2025 - Match 02",
            teams: "Mumbai Indians vs Chennai Super Kings",
            venue: "Wankhede Stadium, Mumbai",
            price: "₹3000 onwards"
        ),
        EventModel(
            id: 3,
            imageUrl: "e3",
            date: (day: "Tue", date: "25", month: "Mar"),
            title: "TATA IPL 2025 - Match 03",
            teams: "Royal Challengers Bangalore vs Kolkata Knight Riders",
            venue: "M. Chinnaswamy Stadium, Bangalore",
            price: "₹2850 onwards"
        ),
        EventModel(
            id: 4,
            imageUrl: "e4",
            date: (day: "Wed", date: "26", month: "Mar"),
            title: "TATA IPL 2025 - Match 04",
            teams: "Delhi Capitals vs Punjab Kings",
            venue: "Arun Jaitley Stadium, Delhi",
            price: "₹2500 onwards"
        ),
        EventModel(
            id: 5,
            imageUrl: "e6",
            date: (day: "Thu", date: "27", month: "Mar"),
            title: "TATA IPL 2025 - Match 05",
            teams: "Gujarat Titans vs Lucknow Super Giants",
            venue: "Narendra Modi Stadium, Ahmedabad",
            price: "₹3200 onwards"
        )
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background color
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 10) {

                    
                    // Filter row
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            // Filters button
                            FilterButton(
                                icon: "line.3.horizontal.decrease",
                                text: "Filters",
                                hasChevron: true,
                                isSelected: false,
                                action: { /* Filter action */ }
                            )
                            
                            // Time filter buttons
                            ForEach(timeFilters, id: \.self) { filter in
                                FilterButton(
                                    text: filter,
                                    isSelected: selectedFilter == filter,
                                    action: { selectedFilter = filter }
                                )
                            }
                        }
                        .padding(.horizontal)
                        
                    }
                    
                    // Event cards
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(events) { event in
                                EventCards(event: event)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

// MARK: - Supporting Views
struct FilterButton: View {
    let icon: String?
    let text: String
    let hasChevron: Bool
    let isSelected: Bool
    let action: () -> Void
    
    init(icon: String? = nil, text: String, hasChevron: Bool = false, isSelected: Bool, action: @escaping () -> Void) {
        self.icon = icon
        self.text = text
        self.hasChevron = hasChevron
        self.isSelected = isSelected
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 14))
                }
                
                Text(text)
                
                if hasChevron {
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12))
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(isSelected ? Color.gray.opacity(0.5) : Color.clear)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
        }
    }
}

struct EventCards: View {
    let event: EventModel
    
    var body: some View {
        VStack(spacing: 0) {
            // Event image
            ZStack(alignment: .top) {
                Image(event.imageUrl)
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .cornerRadius(15)
                
                
            }
            
            // Event details
            HStack(alignment: .top, spacing: 15) {
                // Date box
                VStack {
                    Text(event.date.day)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Text(event.date.date)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text(event.date.month)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                }
                .frame(width: 60)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.2))
                )
                
                // Event details
                VStack(alignment: .leading, spacing: 5) {
                    Text(event.title)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text(event.teams)
                        .font(.subheadline)
                        .foregroundColor(.white)
                    
                    Text(event.venue)
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text(event.price)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                }
                .padding(.vertical, 8)
                
                Spacer()
            }
            .padding(.top, 10)
        }
        .background(Color.black)
    }
}

// MARK: - Data Model
struct EventModel: Identifiable {
    let id: Int
    let imageUrl: String
    let date: (day: String, date: String, month: String)
    let title: String
    let teams: String
    let venue: String
    let price: String
}

// MARK: - Preview
#Preview {
    Sports()
}
