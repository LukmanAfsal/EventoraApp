//
//  SearchPage.swift
//  EventoraApp
//
//  Created by jeboy on 14/02/25.
//

import SwiftUI


struct SearchPage: View {
    @EnvironmentObject private var router: Router

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            HStack{
                BackButton {
                    router.navigateToRoot()
                }
                VStack{
                    Text("Search Page") +
                    Text(" Index")
                        .bold()
                }
            }
        }
    }
}

#Preview {
    SearchPage()
}
