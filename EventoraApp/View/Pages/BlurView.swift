//
//  BlurView.swift
//  EventoraApp
//
//  Created by Abhinand K J on 05/03/25.
//

import SwiftUI

// MARK: - BlurView
struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

#Preview {
    BlurView(style: .dark)
}
