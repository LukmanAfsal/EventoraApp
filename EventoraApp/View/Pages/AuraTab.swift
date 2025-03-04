//
//  AuraTab.swift
//  EventoraApp
//
//  Created by Abhinand K J on 20/02/25.
//


import SwiftUI

enum AuraTab: Int, CaseIterable {
    case forYou = 1
    case events = 2
    case movies = 3
    case sport = 4
    
    var tabItem: TabItemData {
        switch self {
        case .forYou:
            return TabItemData(image: "wand.and.sparkles", title: "For You", color: .cpurple)
        case .events:
            return TabItemData(image: "guitars", title: "Events", color: .orange)
        case .movies:
            return TabItemData(image: "movieclapper", title: "Movies", color: .purple)
        case .sport:
            return TabItemData(image: "figure.disc.sports", title: "Sport", color: .green)
        }
    }
    var gradientColor: Color{
        switch self {
        case .forYou:
            return .cpurple
        case .events:
            return .orange
        case .movies:
            return .purple
        case .sport:
            return .green
        }
    }
    
    var searchPlaceHolder: String{
        switch self {
        case .forYou:
            return "Search your Favourites"
        case .events:
            return "Search your Events"
        case .movies:
            return "Search your Movies"
        case .sport:
            return "Search your Restaurants"
        }
    }
}

struct TabItemData {
    let image: String
    let title: String
    let color: Color
}






