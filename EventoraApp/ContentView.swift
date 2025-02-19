//
//  ContentView.swift
//  EventoraApp
//
//  Created by jeboy on 11/02/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        SplashScreen()
    }
}

struct SplashScreen: View{
    
    @State var splashAnimation: Bool = false
    
    var body: some View {
        ZStack {
            LoginScreen()
                .opacity(splashAnimation ? 1 : 0)
            
            Color(.black)
                .mask {
                    Rectangle()
                        .overlay(
//                            Image("img-Eventora")
                            Image("svg-img")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                                .scaleEffect(splashAnimation ? 170 :  1)
                                .blendMode(.destinationOut)
                            
                        )
                }
        }
        .ignoresSafeArea()
//        .preferredColorScheme(splashAnimation ? nil : .light)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
                withAnimation(.easeInOut(duration: 0.5)){
                    splashAnimation.toggle()
                }
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

