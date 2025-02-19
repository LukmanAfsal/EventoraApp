//
//  ContentView.swift
//  EventoraApp
//
//  Created by jeboy on 11/02/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showSplash = true

    var body: some View {
        ZStack {
            LoginScreen()
                .opacity(showSplash ? 0 : 1) // Fade in the login screen smoothly
            
            if showSplash {
                SplashScreen(showSplash: $showSplash)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: showSplash) // Smooth transition
    }
}

struct SplashScreen: View {
    @Binding var showSplash: Bool
    @State private var splashAnimation = false

    var body: some View {
        ZStack {
            LoginScreen()
                .opacity(splashAnimation ? 1 : 0)
            
            Color.black
                .mask {
                    Rectangle()
                        .overlay(
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                withAnimation(.easeInOut(duration: 0.9)) {
                    splashAnimation.toggle()
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                showSplash = false
            }
        }
    }
}



#Preview {
    ContentView()
}




//struct ContentView: View {
//    @State var isHomeRootScreen = false
//    @State var scaleAmount: CGFloat = 1
//    
//    var body: some View {
//        ZStack{
//            Color(.white)
//            if isHomeRootScreen{
//                LoginScreen()
//            } else{
//                Image("img-Eventora")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .scaleEffect(scaleAmount)
//                    .frame(width: 200)
//                    
//            }
//        }
//        .ignoresSafeArea()
//        .onAppear{
//            //MARK: - Shrink
//            withAnimation(.easeInOut(duration: 1)){
//                scaleAmount = 0.6
//            }
//            //MARK: - Enlarge
//            withAnimation(.easeInOut(duration: 1).delay(1)){
//                scaleAmount = 390
//            }
//            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
//                isHomeRootScreen = true
//            }
//        }
//    }
//}

