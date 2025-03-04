//
//  Router.swift
//  EventoraApp
//
//  Created by Abhinand K J on 19/02/25.
//

import Foundation
import SwiftUI

final class Router: ObservableObject {
    
    
    
    @Published var navPath : [NavDestination] = []
    
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

public enum NavDestination: Codable, Hashable {
    case login
    case signUp
    case home
    case profile

}
