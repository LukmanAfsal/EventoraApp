//
//  ContentView.swift
//  EventoraApp
//
//  Created by Abhinand K J on 11/02/25.
//

import SwiftUI

// MARK: - ContentView (Commented Out)
/*
struct ContentView: View {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
    var body: some View {
        LoginScreen(skippedOnboarding: .constant(false), loginSuccessful: .constant(true))
    }
}
*/

// MARK: - SplashScreen
struct SplashScreen: View {
    
    @State var splashAnimation: Bool = false
    
    var body: some View {
        ZStack {
            // MARK: - LoginScreen Background
            LoginScreen(skippedOnboarding: .constant(false), loginSuccessful: .constant(false))
                .opacity(splashAnimation ? 1 : 0)
            
            // MARK: - Splash Animation
            Color(.black)
                .mask {
                    Rectangle()
                        .overlay(
                            // MARK: - Logo Image
                            Image("svg-img")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                                .scaleEffect(splashAnimation ? 170 : 1)
                                .blendMode(.destinationOut)
                        )
                }
        }
        .ignoresSafeArea()
        
        // MARK: - Splash Animation Trigger
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    splashAnimation.toggle()
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    SplashScreen()
}

// MARK: - ContentView (Alternative Implementation)
/*
struct ContentView: View {
    @State var isHomeRootScreen = false
    @State var scaleAmount: CGFloat = 1
    
    var body: some View {
        ZStack {
            Color(.white)
            if isHomeRootScreen {
                LoginScreen()
            } else {
                Image("img-Eventora")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(scaleAmount)
                    .frame(width: 200)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            // MARK: - Shrink Animation
            withAnimation(.easeInOut(duration: 1)) {
                scaleAmount = 0.6
            }
            
            // MARK: - Enlarge Animation
            withAnimation(.easeInOut(duration: 1).delay(1)) {
                scaleAmount = 390
            }
            
            // MARK: - Transition to LoginScreen
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isHomeRootScreen = true
            }
        }
    }
}
*/
