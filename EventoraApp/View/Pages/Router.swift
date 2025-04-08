//
//  Router.swift
//  EventoraApp
//
//  Created by Abhinand K J on 19/02/25.
//

import Foundation
import SwiftUI

// MARK: - Router
final class Router: ObservableObject {
    
    // MARK: - Properties
    @Published var navPath: [NavDestination] = []
    
    // MARK: - Navigation Methods
    func navigate(to destination: NavDestination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeAll()
    }
}

// MARK: - NavDestination
enum NavDestination: Codable,Equatable,Hashable {
    
    public static func == (lhs: NavDestination, rhs: NavDestination) -> Bool {
        switch (lhs, rhs) {
        case (.login, .login),
            (.signUp, .signUp),
            (.home, .home),
            (.profile, .profile),
            (.forgotPassword, .forgotPassword),
            (.searchpage, .searchpage):
            return true
        case let (.ticketselectionview(lhsEvent), .ticketselectionview(rhsEvent)):
            return lhsEvent.id == rhsEvent.id
        default:
            return false
        }
        
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .login:
            hasher.combine(0)
        case .signUp:
            hasher.combine(1)
        case .home:
            hasher.combine(2)
        case .profile:
            hasher.combine(3)
        case .forgotPassword:
            hasher.combine(4)
        case .searchpage:
            hasher.combine(5)
        case .ticketselectionview(let event):
            hasher.combine(6)
        }
    }
    
    case login
    case signUp
    case home
    case profile
    case forgotPassword
    case searchpage
    case ticketselectionview(event:EvntoraEvent)
}
