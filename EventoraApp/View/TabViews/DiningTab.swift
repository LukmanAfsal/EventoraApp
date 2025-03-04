//
//  DiningTab.swift
//  EventoraApp
//
//  Created by Abhinand K J on 20/02/25.
//

import SwiftUI

struct DiningTab: View {
    var body: some View {
        ZStack {
            Color.black // Black background
                .ignoresSafeArea()
            VStack{
                Text("Dining")
                    .foregroundColor(.white)
                    .padding()
                Text("abhis change")
                    .foregroundColor(.white)
                    .padding()
            }
                
                //.background(.green)
                .font(.title)
                .bold()
        }
    }
}

#Preview {
    DiningTab()
}
