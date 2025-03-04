//
//  SkipButton.swift
//  EventoraApp
//
//  Created by Abhinand K J on 28/02/25.
//

import SwiftUI

struct SkipButton: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Skip")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.all, 12)
                .background(Rectangle().cornerRadius(25).foregroundStyle(Color.white.opacity(0.2)))
                .overlay(RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.purple))
        }
    }
}



#Preview {
    SkipButton()
}
