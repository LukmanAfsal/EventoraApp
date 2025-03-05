//
//  ForYouTabView.swift
//  EventoraApp
//
//  Created by Abhinand K J on 19/02/25.
//

import SwiftUI

// MARK: - For You Tab View
struct ForYouTabView: View {
    @StateObject private var viewModel = ForYouViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                ScrollView {
                    LazyVStack {
                        GradientLine(title: "IN THE SPOTLIGHT")
                        
                        if let spotlight = viewModel.eventResponse?.spotlight {
                            NavigationLink(destination: EventDetailsPage(event: spotlight.toEventoraEvent())) {
                                VStack {
                                    SpotLight(titleMain: spotlight.title, viewModel: viewModel)
                                    DatePlaceBar(eventLocation: spotlight.location, eventTime: spotlight.time, eventDate: spotlight.date)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        } else {
                            ProgressView()
                        }
                        
                        GradientLine(title: "THE BEST OF INDIA")
                        
                        BestOfIndia(viewModel: viewModel)
                        
                        GradientLine(title: "UPCOMING EVENTS")
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadEvents()
        }
    }
}

// MARK: - Best of India View
struct BestOfIndia: View {
    @ObservedObject var viewModel: ForYouViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                if let events = viewModel.eventResponse?.bestOfIndia {
                    ForEach(events) { event in
                        NavigationLink(destination: EventDetailsPage(event: event)) {
                            VStack {
                                if let url = URL(string: event.image) {
                                    AsyncImage(url: url) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                        case .success(let image):
                                            image.resizable()
                                                .scaledToFit()
                                        case .failure:
                                            Color.red
                                        @unknown default:
                                            Color.gray
                                        }
                                    }
                                    .frame(width: 300, height: 400)
                                    .cornerRadius(15)
                                } else {
                                    Color.gray.frame(width: 300, height: 400)
                                }
                                
                                HStack(spacing: 8) {
                                    ZStack(alignment: .top) {
                                        Rectangle()
                                            .fill(Color.cgray)
                                            .frame(width: 60, height: 70)
                                            .cornerRadius(15)
                                        
                                        VStack(spacing: 0) {
                                            Rectangle()
                                                .fill(Color.white)
                                                .frame(width: 60, height: 23)
                                                .clipShape(.rect(topLeadingRadius: 15, topTrailingRadius: 15))
                                            Spacer()
                                        }
                                        .frame(height: 70)
                                        
                                        VStack(spacing: 2) {
                                            let dateParts = event.date.components(separatedBy: ", ")
                                            if dateParts.count == 2 {
                                                Text(dateParts[0])
                                                    .font(.caption)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.black)
                                                
                                                Text(dateParts[1].components(separatedBy: " ")[0])
                                                    .font(.title2)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.white)
                                                
                                                Text(dateParts[1].components(separatedBy: " ")[1])
                                                    .font(.caption)
                                                    .foregroundColor(.white)
                                            }
                                        }
                                        .frame(maxHeight: .infinity, alignment: .center)
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        Text(event.title)
                                            .fontWeight(.bold)
                                            .font(.title3)
                                            .frame(maxHeight: 50)
                                            .foregroundColor(.white)
                                            .lineLimit(2)
                                            .multilineTextAlignment(.leading)
                                        
                                        Text(event.location)
                                            .lineLimit(1)
                                            .foregroundStyle(.white)
                                    }
                                }
                                .frame(width: 300, alignment: .leading)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                } else {
                    Text("Loading events...")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

// MARK: - Gradient Line
struct GradientLine: View {
    var title: String
    var body: some View {
        HStack {
            Rectangle()
                .foregroundStyle(
                    LinearGradient(gradient: Gradient(colors: [.black, .white]), startPoint: .leading, endPoint: .trailing)
                )
                .frame(width: 100, height: 2)
            Text(title)
                .foregroundStyle(.gray)
                .fontWeight(.bold)
            Rectangle()
                .foregroundStyle(
                    LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .leading, endPoint: .trailing)
                )
                .frame(width: 100, height: 2)
        }
        .padding(.vertical, 16)
    }
}

// MARK: - Spotlight View
struct SpotLight: View {
    var titleMain: String
    var viewModel: ForYouViewModel
    
    var body: some View {
        VStack {
            VideoPlayerView(videoName: "")
                .frame(width: 370, height: 500)
                .cornerRadius(15)
                .padding(.horizontal)
            
            Text(titleMain)
                .fontWeight(.bold)
                .font(.title2)
                .padding(.leading, -80)
                .padding(10)
                .foregroundStyle(.white)
        }
    }
}

// MARK: - Date & Place Bar
struct DatePlaceBar: View {
    var eventLocation: String
    var eventTime: String
    var eventDate: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color.cgray)
                .frame(width: 380, height: 70)
                .cornerRadius(15)
            
            HStack {
                VStack(spacing: 0) {
                    let dateParts = eventDate.components(separatedBy: ", ")
                    if dateParts.count == 2 {
                        Text(dateParts[0]).font(.caption).fontWeight(.bold)
                        Text(dateParts[1].components(separatedBy: " ")[0]).font(.title2).fontWeight(.bold)
                        Text(dateParts[1].components(separatedBy: " ")[1]).font(.caption)
                    } else {
                        Text("MON").font(.caption).fontWeight(.bold)
                        Text("12").font(.title2).fontWeight(.bold)
                        Text("FEB").font(.caption)
                    }
                }
                .frame(width: 60, height: 70)
                .background(Color.white)
                .clipShape(.rect(topLeadingRadius: 15, bottomLeadingRadius: 15))
                .foregroundColor(.black)
                
                VStack(alignment: .leading) {
                    Text(eventLocation).font(.headline)
                    Text(eventTime).font(.subheadline)
                }
                .padding(.leading, 16)
                .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.white)
                    .padding(.trailing, 16)
            }
            .frame(width: 380, height: 70)
        }
    }
}

// MARK: - Spotlight to Event Conversion
extension Spotlight {
    func toEventoraEvent() -> EvntoraEvent {
        return EvntoraEvent(
            id: "spotlight",
            image: self.image,
            title: self.title,
            date: self.date,
            location: self.location,
            gatesOpenTime: self.gatesOpenTime,
            time: self.time,
            price: self.price,
            distance: self.distance,
            description: self.description,
            artist: self.artist
        )
    }
}

// MARK: - Preview
#Preview {
    ForYouTabView()
}
