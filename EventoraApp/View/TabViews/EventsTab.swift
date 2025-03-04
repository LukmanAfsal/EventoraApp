//
//  EventsTab.swift
//  EventoraApp
//
//  Created by Abhinand K J on 20/02/25.
//

import SwiftUI


struct EventsTab: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            Text("Events Available")
                .foregroundColor(.white)
                .font(.title)
                .bold()
        }
    }
}

#Preview {
    EventsTab()
}
