//
//  LoginScreen2.swift
//  EventoraApp
//
//  Created by Abhinand K J on 28/02/25.
//

import SwiftUI

// MARK: - LoginScreen2 View
struct LoginScreen2: View {
    // MARK: - AppStorage Properties
    @AppStorage("skippedOnboarding") var skippedOnboarding: Bool = false
    @AppStorage("isloggedin") var isLoggedIn: Bool = false
    
    // MARK: - EnvironmentObject
    @EnvironmentObject private var router: Router
    
    var body: some View {
        ZStack {
            // MARK: - Background Video
            VideoPlayerView(videoName: "PartyMood1")
                .edgesIgnoringSafeArea(.all)
            
            // MARK: - Logo and Tagline
            VStack {
                Image("img-Eventora3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 270)
                Text("Discover | Book | Experience")
                    .foregroundStyle(.white)
            }
            .padding(.bottom, 300)
            
            // MARK: - Buttons
            VStack {
                Spacer()
                
                // MARK: - Login Button
                Button(action: {
                    skippedOnboarding = false
                    isLoggedIn = false
                    router.navigateToRoot() // Navigate to the Login Page
                }) {
                    Text("Log In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.cpurple)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                }
                .padding(.bottom, 10)
                
                // MARK: - Sign Up Button
                Button(action: {
                    router.navigate(to: .signUp) // Navigate to the Sign Up Page
                }) {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.cpurple)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                }
                .padding(.bottom, 200)
            }
        }
        // MARK: - Hide Navigation Bar
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
}

// MARK: - Preview
#Preview {
    LoginScreen2()
}
