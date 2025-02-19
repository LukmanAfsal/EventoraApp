//
//  TermsOfService.swift
//  EventoraApp
//
//  Created by jeboy on 13/02/25.
//

import SwiftUI

struct TermsOfService: View {
    var body: some View {
        VStack{
            Text("☣︎")
                .font(.system(size: 90))
                .foregroundStyle(.red)
            Text("Terms of service: if you use our app your datas will be sold to third party for sure. Also your datas will be sold to call centers for scamming and blackmailing purposes.")
                .padding()
        }
    }
}

#Preview {
    TermsOfService()
}
