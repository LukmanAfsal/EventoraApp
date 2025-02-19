//
//  SignUpPage.swift
//  EventoraApp
//
//  Created by jeboy on 13/02/25.
//

import SwiftUI

struct SignUpPage: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                VideoPlayerView(videoName: "PartyMood1")
                    .edgesIgnoringSafeArea(.all)
                
                
                VStack(spacing: 20) {
                    
                    VStack {
                        Image("img-Eventora3")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 270)
                        Text("Discover | Book | Experience")
                            .foregroundStyle(.white)
                    }
                    .padding(.top, 90)
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        Text("Create an Account")
                            .bold()
                            .font(.title2)
                            .foregroundColor(.white)
                        
                        TextField("Username", text: $username)
                            .padding()
                            .foregroundStyle(.white)
                            .background(Color.white.opacity(0.4))
                            .cornerRadius(8)
                            .padding(.horizontal, 20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.purple, lineWidth: 1)
                                    .padding(.horizontal, 20)
                            )
                        
                        TextField("Email", text: $email)
                            .padding()
                            .foregroundStyle(.white)
                            .background(Color.white.opacity(0.4))
                            .cornerRadius(8)
                            .padding(.horizontal, 20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.purple, lineWidth: 1)
                                    .padding(.horizontal, 20)
                            )
                        
                        SecureField("Password", text: $password)
                            .padding()
                            .foregroundStyle(.white)
                            .background(Color.white.opacity(0.4))
                            .cornerRadius(8)
                            .padding(.horizontal, 20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.purple, lineWidth: 1)
                                    .padding(.horizontal, 20)
                            )
                        
                        SecureField("Confirm Password", text: $confirmPassword)
                            .padding()
                            .foregroundStyle(.white)
                            .background(Color.white.opacity(0.4))
                            .cornerRadius(8)
                            .padding(.horizontal, 20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.purple, lineWidth: 1)
                                    .padding(.horizontal, 20)
                            )
                        
                        Button(action: {
                            print("Sign-Up button tapped")
                        }) {
                            Text("Sign Up")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.purple)
                                .cornerRadius(8)
                                .padding(.horizontal, 20)
                        }
                        
                        HStack {
                            Text("Already have an account?")
                                .foregroundStyle(Color.white)
                            NavigationLink(destination: LoginScreen()) {
                                Text("Log In")
                                    .foregroundStyle(Color.purple)
                            }
                        }
                        .padding(.bottom, 30)
                    }
                }
            }
        }
    }
}
#Preview {
    SignUpPage()
}
