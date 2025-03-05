//
//  LogInViewModel.swift
//  EventoraApp
//
//  Created by Abhinand K J on 27/02/25.
//

import Foundation
import FirebaseAuth

@MainActor
final class LogInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLogInSuccess: Bool = false
    @Published var errorMessage: String? = nil
    
    // MARK:- Email Validation
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    // MARK:- Password Validation
    func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6
    }
    
    // MARK:- Login Function
    func login() async {
        // MARK:- Field Validation
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
        
        // MARK:- Firebase Login Attempt
        do {
            let returnedUserData = try await AuthenticationManager.shared.signIn(email: email, password: password)
            print("Login Success")
            isLogInSuccess.toggle()
            print(returnedUserData)
        } catch {
            // MARK:- Error Handling
            if let error = error as NSError? {
                switch error.code {
                case AuthErrorCode.invalidCredential.rawValue:
                    errorMessage = "email not found. Please Sign Up."
                case AuthErrorCode.wrongPassword.rawValue:
                    errorMessage = "Incorrect password. Please try again."
                default:
                    errorMessage = "Login failed. Please try again."
                }
            }
            print("Login Error: \(error)")
        }
    }
}
