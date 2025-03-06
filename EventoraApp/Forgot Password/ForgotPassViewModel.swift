//
//  ForgotPassViewModel.swift
//  EventoraApp
//
//  Created by Abhinand K J on 06/03/25.
//

import Foundation
import FirebaseAuth

@MainActor
final class ForgotPasswordViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var errorMessage: String? = nil
    @Published var successMessage: String? = nil
    @Published var showValidationErrors: Bool = false

    // MARK: - Send Reset Link
    func sendResetLink() async {
        guard !email.isEmpty else {
            errorMessage = "Please enter your email address."
            showValidationErrors = true
            return
        }

        guard isValidEmail(email) else {
            errorMessage = "Please enter a valid email address."
            showValidationErrors = true
            return
        }

        do {
            try await AuthenticationManager.shared.resetPassword(email: email)
            successMessage = "A password reset email has been sent to \(email)."
            errorMessage = nil
        } catch {
            errorMessage = "Failed to send password reset email. Please try again."
            successMessage = nil
        }
    }

    // MARK: - Email Validation
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
