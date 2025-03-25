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
public enum NavDestination: Codable, Hashable {
    case login
    case signUp
    case home
    case profile
    case forgotPassword
}
