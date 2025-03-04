//
//  SignUpViewModel.swift
//  EventoraApp
//
//  Created by Abhinand K J on 27/02/25.
//

import Foundation

@MainActor
final class SignUpViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isSignInSuccess: Bool = false
    @Published var errorMessage: String? = nil

    // Validate email format
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    // Validate password length
    func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6
    }

    // Sign up function
    func signUp() async {
        // Validate fields
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields."
            return
        }

        guard isValidEmail(email) else {
            errorMessage = "Please enter a valid email address."
            return
        }

        guard isValidPassword(password) else {
            errorMessage = "Password must be at least 6 characters long."
            return
        }

        // Call Firebase to create a new user
        do {
            let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
            print("Sign Up Success")
            isSignInSuccess = true
            print(returnedUserData)
        } catch {
            errorMessage = error.localizedDescription
            print("Sign Up Error: \(error)")
        }
    }
}
