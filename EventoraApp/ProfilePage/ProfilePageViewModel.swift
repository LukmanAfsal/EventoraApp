//
//  ProfilePageViewModel.swift
//  EventoraApp
//
//  Created by Abhinand K J on 03/03/25.
//

import Foundation

// MARK: - ProfilePageViewModel
@MainActor
final class ProfilePageViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var isUserLoggedIn: Bool = false
    @Published var userLoggedOut: Bool = false
    
    // MARK: - Check User Logged In
    /// Checks if the user is currently logged in by attempting to fetch the authenticated user.
    func checkUserLoggedIn() {
        do {
            _ = try AuthenticationManager.shared.getAuthenticatedUser()
            isUserLoggedIn = true
        } catch {
            isUserLoggedIn = false
        }
    }
    // MARK: - Delete Account
    /// Deletes the user's account and updates the state accordingly.
    func deleteAccount() async {
        do {
            try await AuthenticationManager.shared.deleteUser()
            isUserLoggedIn = false
            userLoggedOut.toggle()
        } catch {
            print("Error deleting account: \(error)")
        }
    }
    
    // MARK: - Sign Out
    /// Signs out the user and updates the state accordingly.
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
        isUserLoggedIn = false
        userLoggedOut.toggle()
    }
}
