////
////  ForYouModel.swift
////  EventoraApp
////
////  Created by jeboy on 27/02/25.
////
//
import Foundation

struct EventResponse: Codable {
    let spotlight: Spotlight
    let bestOfIndia: [EvntoraEvent]
}

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

struct Artist: Codable {
    let name: String
    let image: String
}

