//
//  ProfilePage.swift
//  EventoraApp
//
//  Created by Abhinand K J on 14/02/25.
//

import SwiftUI

// MARK: - ProfilePage View
struct ProfilePage: View {
    // MARK: - StateObject
    @StateObject private var viewModel = ProfilePageViewModel()
    
    // MARK: - EnvironmentObject
    @EnvironmentObject private var router: Router
    
    // MARK: - AppStorage
    @AppStorage("skippedOnboarding") var skippedOnboarding: Bool = false
    @AppStorage("isloggedin") var isLoggedIn: Bool = false
    
    var body: some View {
        ZStack {
            // MARK: - Background Gradient
            BackgroundRadient(gradientColor: .cpurple)
            
            // MARK: - Conditional View
            if viewModel.isUserLoggedIn {
                // MARK: - Logged In View
                List {
                    // Log Out Button
                    Button("Log Out") {
                        Task {
                            do {
                                try viewModel.signOut()
                                // Navigate back to login screen
                            } catch {
                                print(error)
                            }
                        }
                    }
                    
                    // Delete Account Button
                    Button("Delete") {
                        Task {
                            do {
                                // TODO: Add delete user functionality
                                // Navigate back to login screen
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
            } else {
                // MARK: - Not Logged In View
                LoginScreen2()
            }
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
        .onAppear {
            // MARK: - Check Authentication Status
            viewModel.checkUserLoggedIn()
        }
        .onChange(of: viewModel.userLoggedOut) {
            // MARK: - Handle Logout
            skippedOnboarding = false
            isLoggedIn = false
            router.navigateToRoot()
        }
    }
}

// MARK: - Preview
#Preview {
    ProfilePage()
        // .environmentObject(Router())
}
