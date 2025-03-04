//
//  BackButton.swift
//  EventoraApp
//
//  Created by Abhinand K J on 28/02/25.
//

import SwiftUI

struct BackButton: View {
    var action: () -> Void // Closure to handle the button action
    
    var body: some View {
        Button(action: action) { // Trigger the action when the button is tapped
            HStack {
                Image(systemName: "chevron.backward")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .padding()
        }
    }
}

#Preview {
    BackButton {
        debugPrint("Hello")
    }
}
