//
//  MoviesTab.swift
//  EventoraApp
//
//  Created by Abhinand K J on 20/02/25.
//

import SwiftUI

struct TechAndBusiness: View {
    
    @EnvironmentObject private var router: Router
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            Text("Movies")
                .foregroundColor(.white)
                .font(.title)
                .bold()
                .onTapGesture {
                    router.navigate(to: .ticketselectionview(event: EvntoraEvent.samplePreviewEvent))
                }
        }
    }
}

#Preview {
    TechAndBusiness()
}
