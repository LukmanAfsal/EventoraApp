//
//  AuraTab.swift
//  EventoraApp
//
//  Created by jeboy on 19/02/25.
//

import SwiftUI

// Tab.swift
import SwiftUI

enum AuraTab: Int, CaseIterable {
    case forYou = 1
    case events = 2
    case movies = 3
    case dining = 4
    
    var tabItem: TabItemData {
        switch self {
        case .forYou:
            return TabItemData(image: "wand.and.sparkles", title: "For You", color: .cpurple)
        case .events:
            return TabItemData(image: "guitars", title: "Events", color: .green)
        case .movies:
            return TabItemData(image: "movieclapper", title: "Movies", color: .purple)
        case .dining:
            return TabItemData(image: "fork.knife", title: "Dining", color: .orange)
        }
    }
}

struct TabItemData {
    let image: String
    let title: String
    let color: Color
}



