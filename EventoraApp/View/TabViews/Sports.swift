//
//  DiningTab.swift
//  EventoraApp
//
//  Created by Abhinand K J on 20/02/25.
//

import SwiftUI

struct Sports: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack{
                Text("Dining")
                    .foregroundColor(.white)
                    .padding()
                Text("abhis change")
                    .foregroundColor(.white)
                    .padding()
            }

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
    Sports()
}
