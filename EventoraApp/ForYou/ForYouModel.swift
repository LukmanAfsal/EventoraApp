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
struct EvntoraEvent: Codable, Identifiable {
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
}

// MARK: - Artist Model
struct Artist: Codable {
    let name: String
    let image: String
}
