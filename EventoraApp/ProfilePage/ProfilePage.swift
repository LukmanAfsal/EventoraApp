//
//  ProfilePage.swift
//  EventoraApp
//
//  Created by jeboy on 14/02/25.
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
                // Show Logout Button if user is logged in
                List {
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
                    Button("Delete") {
                        Task {
                            do {
                                //try to delete User
                                // Navigate back to login screen
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
            } else {
                // Show LoginPromptScreen if user is not logged in
                LoginScreen2()
            }
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
        .onAppear {
            viewModel.checkUserLoggedIn() // Check authentication status when the view appears
        }
        .onChange(of: viewModel.userLoggedOut) {
            skippedOnboarding = false
            isLoggedIn = false
            router.navigateToRoot()
        }
    }
}

#Preview {
    ProfilePage()
//        .environmentObject(Router())
}
