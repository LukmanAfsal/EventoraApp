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
                        
                        TextField(text: $username){
                            Text("Username")
                                .foregroundStyle(.gray)
                        }
                            .padding()
                            .foregroundStyle(.white)
                            .background(Color.cgray.opacity(0.4))
                            .cornerRadius(8)
                            .padding(.horizontal, 20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.purple, lineWidth: 1)
                                    .padding(.horizontal, 20)
                            )
                        
                        TextField(text: $email){
                            Text("Email")
                                .foregroundStyle(.gray)
                        }
                            .padding()
                            .foregroundStyle(.white)
                            .background(Color.cgray.opacity(0.4))
                            .cornerRadius(8)
                            .padding(.horizontal, 20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.purple, lineWidth: 1)
                                    .padding(.horizontal, 20)
                            )
                        
                        SecureField(text: $password){
                            Text("Password")
                                .foregroundStyle(.gray)
                        }
                            .padding()
                            .foregroundStyle(.white)
                            .background(Color.cgray.opacity(0.4))
                            .cornerRadius(8)
                            .padding(.horizontal, 20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.purple, lineWidth: 1)
                                    .padding(.horizontal, 20)
                            )
                        
                        SecureField(text: $confirmPassword){
                            Text("Confirm Passwor")
                                .foregroundStyle(.gray)
                        }
                            .padding()
                            .foregroundStyle(.white)
                            .background(Color.cgray.opacity(1))
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
