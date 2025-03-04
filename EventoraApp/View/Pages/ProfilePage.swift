//
//  ProfilePage.swift
//  EventoraApp
//
//  Created by jeboy on 14/02/25.
//

import SwiftUI

struct ProfilePage: View {
    @AppStorage("username") private var username = ""
    @AppStorage("isDarkMode") private var isDarkMode = true
    @AppStorage("refreshInterval") private var refreshInterval = 10
    var body: some View {
//        ZStack{
//            BackgroundGradient(gradientColor: .gray)
            
            NavigationView {
                Form {
                    Section(header: Text("User Settings")) {
                        TextField("Username", text: $username)
                        
                        Toggle("Dark Mode", isOn: $isDarkMode)
                        
                        Stepper("Refresh every \(refreshInterval) minutes",
                               value: $refreshInterval, in: 1...60)
                    }
                    
                    Section(header: Text("Saved Data")) {
                        Text("Username: \(username)")
                        Text("Dark Mode: \(isDarkMode ? "Enabled" : "Disabled")")
                        Text("Refresh Interval: \(refreshInterval) minutes")
                    }
                    
                    Section {
                        Button("Reset to Defaults") {
                            resetDefaults()
                        }
                    }
                }
                .navigationTitle("Profile Page")
                .preferredColorScheme(isDarkMode ? .dark : .light)
            }
        }
        
        func resetDefaults() {
            username = ""
            isDarkMode = true
            refreshInterval = 10
        }
    }

            
//            HStack{
//                Image(systemName: "arrow.left")
//                    .bold()
//                    .font(.system(size: 22))
//                    .foregroundStyle(.white)
//                Text("Profile")
//                    .bold()
//                    .font(.system(size: 22))
//                    .foregroundStyle(.white)
//                Spacer()
//            }
//            .padding()
//        }
#Preview {
    ProfilePage()
}
