//
//  ForYouModel.swift
//  EventoraApp
//
//  Created by Abhinand K J on 04/03/25.
//

import Foundation

// MARK: - Event Response Model
struct EventResponse: Codable {
    let spotlight: Spotlight
    let bestOfIndia: [EvntoraEvent]
}

// MARK: - Spotlight Model
struct Spotlight: Codable {
    let title: String
    let location: String
    let time: String
    let date: String
    let gatesOpenTime: String
    let price: Int
    let image: String
    let distance: String
    let description: String
    let artist: Artist
}

// MARK: - Event Model
struct EvntoraEvent: Codable, Identifiable,Equatable {
    
    
    static func == (lhs: EvntoraEvent, rhs: EvntoraEvent) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: String
    let image: String
    let title: String
    let date: String
    let location: String
    let gatesOpenTime: String
    let time: String
    let price: Int
    let distance: String
    let description: String
    let artist: Artist
    let seatingType: Int?
    
    static let samplePreviewEvent = EvntoraEvent(
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
}

// MARK: - Artist Model
struct Artist: Codable {
    let name: String
    let image: String
}
