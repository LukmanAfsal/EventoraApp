//
//  DiningTab.swift
//  EventoraApp
//
//  Created by jeboy on 19/02/25.
//

import SwiftUI

struct DiningTab: View {
    var body: some View {
        ZStack {
            Color.black // Black background
                .ignoresSafeArea()

            Text("Dining")
                .foregroundColor(.white)
                .padding()
            
                
                //.background(.green)
                .font(.title)
                .bold()
        }
    }
}

#Preview {
    DiningTab()
}
