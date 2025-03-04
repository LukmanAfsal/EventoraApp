//
//  ForYouColor 2.swift
//  EventoraApp
//
//  Created by Abhinand K J on 20/02/25.
//


import SwiftUI

struct BackgroundRadient: View {
    let gradientColor : Color
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [gradientColor,.black, .black,.black,.black, .black]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}


#Preview {
    BackgroundRadient(gradientColor: .cpurple)
    
}
