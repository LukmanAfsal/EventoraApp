//
//  LoginScreen2.swift
//  EventoraApp
//
//  Created by Abhinand K J on 28/02/25.
//

import SwiftUI

struct LoginScreen2: View {
    @AppStorage("skippedOnboarding") var skippedOnboarding: Bool = false
    @AppStorage("isloggedin") var isLoggedIn: Bool = false
    
    @EnvironmentObject private var router: Router
    var body: some View {
        ZStack {
            VideoPlayerView(videoName: "PartyMood1")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("img-Eventora3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 270)
                Text("Discover | Book | Experience")
                    .foregroundStyle(.white)
            }
            .padding(.bottom,300)
            
            
            VStack {
                Spacer()
                
                // Login Button
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
                
                .padding(.bottom,10)
                Button(action: {
                    router.navigate(to: .signUp) // Navigate to the Login Page
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
                
                .padding(.bottom,200)
            }
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
}
#Preview {
    LoginScreen2()
}
