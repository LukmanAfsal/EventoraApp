//
//  ProfilePage.swift
//  EventoraApp
//
//  Created by Abhinand K J on 14/02/25.
//

import SwiftUI

struct ProfilePage: View {
    @StateObject private var viewModel = ProfilePageViewModel()
    @EnvironmentObject private var router: Router
    @AppStorage("skippedOnboarding") var skippedOnboarding: Bool = false
    @AppStorage("isloggedin") var isLoggedIn: Bool = false
    
    var body: some View {
        ZStack {
            BackgroundRadient(gradientColor: .cpurple)
            
            if viewModel.isUserLoggedIn {
                List {
                    // Log Out Button
                    Button("Log Out") {
                        Task {
                            do {
                                try viewModel.signOut()
                            } catch {
                                print(error)
                            }
                        }
                    }
                    
                    // Delete Account Button
                    Button("Delete Account", role: .destructive) {
                        Task {
                            await viewModel.deleteAccount()
                        }
                    }
                }
            } else {
                LoginScreen2()
            }
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
        .onAppear {
            viewModel.checkUserLoggedIn()
        }
        .onChange(of: viewModel.userLoggedOut) {
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
