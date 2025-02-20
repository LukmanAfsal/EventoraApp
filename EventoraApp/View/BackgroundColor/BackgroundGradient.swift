//
//  ForYouColor.swift
//  EventoraApp
//
//  Created by jeboy on 14/02/25.
//

import SwiftUI

struct BackgroundGradient: View {
    
    let gradientColor: Color
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [gradientColor,.black, .black,.black,.black, .black]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

#Preview {
    BackgroundGradient(gradientColor: .purple)
}
