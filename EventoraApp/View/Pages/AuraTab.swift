//
//  AuraTab.swift
//  EventoraApp
//
//  Created by Abhinand K J on 20/02/25.
//

import SwiftUI

// MARK: - AuraTab Enum
enum AuraTab: Int, CaseIterable {
    case forYou = 1
    case events = 2
    case techAndBusiness = 3
    case sport = 4
    
    // MARK: - Tab Item Data
    var tabItem: TabItemData {
        switch self {
        case .forYou:
            return TabItemData(image: "wand.and.sparkles", title: "For You", color: .cpurple)
        case .events:
            return TabItemData(image: "guitars", title: "Events", color: .orange)
        case .techAndBusiness:
            return TabItemData(image: "movieclapper", title: "Tech & Business", color: .purple)
        case .sport:
            return TabItemData(image: "figure.disc.sports", title: "Sport", color: .green)
        }
    }
    
    // MARK: - Gradient Color
    var gradientColor: Color {
        switch self {
        case .forYou:
            return .cpurple
        case .events:
            return .orange
        case .techAndBusiness:
            return .purple
        case .sport:
            return .green
        }
    }
    
    // MARK: - Search Placeholder
    var searchPlaceHolder: String {
        switch self {
        case .forYou:
            return "Search your Favourites"
        case .events:
            return "Search your Events"
        case .techAndBusiness:
            return "Search your Movies"
        case .sport:
            return "Search your Restaurants"
        }
    }
}

// MARK: - TabItemData Struct
struct TabItemData {
    let image: String
    let title: String
    let color: Color
}
