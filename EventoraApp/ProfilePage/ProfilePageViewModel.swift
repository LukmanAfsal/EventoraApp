//
//  ProfilePageViewModel.swift
//  EventoraApp
//
//  Created by Abhinand K J on 03/03/25.
//

import Foundation

@MainActor
final class ProfilePageViewModel: ObservableObject {
    @Published var isUserLoggedIn: Bool = false
    @Published var userLoggedOut: Bool = false
    func checkUserLoggedIn() {
        do {
            _ = try AuthenticationManager.shared.getAuthenticatedUser()
            isUserLoggedIn = true
        } catch {
            isUserLoggedIn = false
        }
    }
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
        isUserLoggedIn = false
        userLoggedOut.toggle()
    }
}
