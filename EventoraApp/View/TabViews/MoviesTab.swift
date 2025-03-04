//
//  MoviesTab.swift
//  EventoraApp
//
//  Created by Abhinand K J on 20/02/25.
//

import SwiftUI

struct MoviesTab: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            Text("Movies")
                .foregroundColor(.white)
                .font(.title)
                .bold()
        }
    }
}

#Preview {
    MoviesTab()
}
