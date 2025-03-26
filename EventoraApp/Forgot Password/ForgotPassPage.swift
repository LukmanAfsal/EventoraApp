//
//  ForgotPassPage.swift
//  EventoraApp
//
//  Created by Abhinand K J on 06/03/25.
//

import SwiftUI

struct ForgotPassPage: View {
    @StateObject private var viewModel = ForgotPasswordViewModel()
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var router: Router


    var body: some View {
        ZStack {
            // Background Gradient or Image
            BackgroundRadient(gradientColor: .cpurple)

            VStack(spacing: 20) {
                // Title
                Text("Forgot Password")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)

                // Description
                Text("Enter your email address to receive a password reset link.")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)

                // Email TextField
                TextField("Email", text: $viewModel.email)
                    .frame(height: 50)
                    .padding(.horizontal, 20)
                    .background(Color.cgray.opacity(0.9))
                    .foregroundStyle(.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(viewModel.showValidationErrors && viewModel.email.isEmpty ? Color.red : Color.purple, lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                
                // Error Message
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.horizontal, 20)
                }

                // Success Message
                if let successMessage = viewModel.successMessage {
                    Text(successMessage)
                        .foregroundColor(.green)
                        .font(.caption)
                        .padding(.horizontal, 20)
                }

                // Send Reset Link Button
                Button(action: {
                    Task {
                        await viewModel.sendResetLink()
                    }
                }) {
                    Text("Send Reset Link")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.purple)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }

                // Back to Login Button
                Button(action: {
                    router.navigateBack()
                }) {
                    Text("Back to Login")
                        .foregroundStyle(Color.purple)
                        .underline()
                        .fontWeight(.semibold)
                }


                Spacer()
            }
            .padding(.top, 50)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ForgotPassPage()
}
