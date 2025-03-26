//
//  SignUpPage.swift
//  EventoraApp
//
//  Created by Abhinand K J on 13/02/25.
//

import SwiftUI

// MARK: - SignUpPage View
struct SignUpPage: View {
    // MARK: - State Properties
    @State private var fullName: String = ""
    @State private var confirmPassword: String = ""
    @StateObject private var viewModel = SignUpViewModel()
    @EnvironmentObject private var router: Router
    @State private var showValidationErrors: Bool = false
    
    // MARK: - AppStorage
    @AppStorage("isloggedin") var isLoggedIn: Bool = false
    
    var body: some View {
        ZStack {
            // MARK: - Background Video
            VideoPlayerView(videoName: "PartyMood1")
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                // MARK: - Header (Back and Skip Buttons)
                HStack {
                    BackButton {
                        router.navigateBack()
                    }
                    
                    Spacer()
                    
                    VStack {
                        SkipButton()
                            .onTapGesture {
                                router.navigateToRoot()
                            }
                    }
                    .padding()
                }
                
                // MARK: - Logo and Tagline
                VStack {
                    Image("img-Eventora3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 270)
                    Text("Discover | Book | Experience")
                        .foregroundStyle(.white)
                }
                .padding(.top, 60)
                
                Spacer()
                
                // MARK: - Sign Up Form
                VStack(spacing: 20) {
                    Text("Create an Account")
                        .bold()
                        .font(.title2)
                        .foregroundColor(.white)
                    
                    // MARK: - Full Name Field
                    VStack(alignment: .leading, spacing: 4) {
                        TextField(text: $fullName) {
                            Text("Full Name")
                                .foregroundStyle(.gray.opacity(0.5))
                        }
                        .frame(height: 20)
                        .padding()
                        .background(Color.cgray)
                        .foregroundStyle(.white)
                        .cornerRadius(8)
                        .padding(.horizontal, 20)
                        .textContentType(.emailAddress)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(showValidationErrors && fullName.isEmpty ? Color.red : Color.purple, lineWidth: 1)
                                .padding(.horizontal, 20)
                        )
                        
                        if showValidationErrors && fullName.isEmpty {
                            Text("Full Name is required")
                                .foregroundColor(.red)
                                .font(.caption)
                                .padding(.horizontal, 20)
                        }
                    }
                    
                    // MARK: - Email Field
                    VStack(alignment: .leading, spacing: 4) {
                        TextField(text: $viewModel.email) {
                            Text("Email")
                                .foregroundStyle(.gray.opacity(0.5))
                        }
                        .frame(height: 20)
                        .padding()
                        .background(Color.cgray)
                        .foregroundStyle(.white)
                        .cornerRadius(8)
                        .padding(.horizontal, 20)
                        .textContentType(.emailAddress)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(showValidationErrors && viewModel.email.isEmpty ? Color.red : Color.purple, lineWidth: 1)
                                .padding(.horizontal, 20)
                        )
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        
                        if showValidationErrors && viewModel.email.isEmpty {
                            Text("Email is required")
                                .foregroundColor(.red)
                                .font(.caption)
                                .padding(.horizontal, 20)
                        }
                    }
                    
                    // MARK: - Password Field
                    VStack(alignment: .leading, spacing: 4) {
                        SecureField(text: $viewModel.password) {
                            Text("Password")
                                .foregroundStyle(.gray.opacity(0.5))
                        }
                        .frame(height: 20)
                        .padding()
                        .background(Color.cgray)
                        .foregroundStyle(.white)
                        .cornerRadius(8)
                        .padding(.horizontal, 20)
                        .textContentType(.emailAddress)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(showValidationErrors && viewModel.password.isEmpty ? Color.red : Color.purple, lineWidth: 1)
                                .padding(.horizontal, 20)
                        )
                        
                        if showValidationErrors && viewModel.password.isEmpty {
                            Text("Password is required")
                                .foregroundColor(.red)
                                .font(.caption)
                                .padding(.horizontal, 20)
                        }
                    }
                    
                    // MARK: - Confirm Password Field
                    VStack(alignment: .leading, spacing: 4) {
                        SecureField(text: $confirmPassword) {
                            Text("Confirm Password")
                                .foregroundStyle(.gray.opacity(0.5))
                        }
                        .frame(height: 20)
                        .padding()
                        .background(Color.cgray)
                        .foregroundStyle(.white)
                        .cornerRadius(8)
                        .padding(.horizontal, 20)
                        .textContentType(.emailAddress)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(showValidationErrors && confirmPassword.isEmpty ? Color.red : Color.purple, lineWidth: 1)
                                .padding(.horizontal, 20)
                        )
                        
                        if showValidationErrors && confirmPassword.isEmpty {
                            Text("Confirm Password is required")
                                .foregroundColor(.red)
                                .font(.caption)
                                .padding(.horizontal, 20)
                        } else if showValidationErrors && viewModel.password != confirmPassword {
                            Text("Passwords do not match")
                                .foregroundColor(.red)
                                .font(.caption)
                                .padding(.horizontal, 20)
                        }
                    }
                    
                    // MARK: - General Error Message
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                            .padding(.horizontal, 20)
                    }
                    
                    // MARK: - Sign Up Button
                    Button(action: {
                        if fullName.isEmpty || viewModel.email.isEmpty || viewModel.password.isEmpty || confirmPassword.isEmpty || viewModel.password != confirmPassword {
                            showValidationErrors = true
                        } else {
                            Task {
                                viewModel.name = fullName
                                await viewModel.signUp()
                            }
                        }
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
                    
                    // In your SignUpPage view
                    .onChange(of: viewModel.isSignInSuccess) { _, newValue in
                        if newValue {
                            isLoggedIn = true
                            // Add a small delay to ensure state changes are processed
                            router.navigateToRoot()
                        }
                    }
                    
                    // MARK: - Login Link
                    HStack {
                        Text("Already have an account?")
                            .foregroundStyle(Color.white)
                        Button("Login") {
                            router.navigateToRoot()
                        }
                        .foregroundStyle(.cpurple)
                    }
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Preview
#Preview {
    SignUpPage()
        .environmentObject(Router())
}
