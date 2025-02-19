//
//  ForYouColor.swift
//  EventoraApp
//
//  Created by jeboy on 14/02/25.
//

import SwiftUI

struct ForYouColor: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.cpurple,.black, .black,.black,.black, .black]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

#Preview {
    ForYouColor()
}
