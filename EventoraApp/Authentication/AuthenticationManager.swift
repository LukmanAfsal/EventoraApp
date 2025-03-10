//
//  AuthenticationManager.swift
//  EventoraApp
//
//  Created by Abhinand K J on 20/02/25.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import GoogleSignIn


// MARK: - AuthDataResultModel
/// A model representing the authenticated user's data.
struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

// MARK: - AuthenticationManager
/// A singleton class to manage Firebase authentication operations.
final class AuthenticationManager {
    // MARK: - Singleton Instance
    static let shared = AuthenticationManager()
    
    // MARK: - Private Initializer
    private init() { }
    
    // MARK: - Get Authenticated User
    /// Retrieves the currently authenticated user.
    /// - Throws: An error if no user is currently authenticated.
    /// - Returns: An `AuthDataResultModel` representing the authenticated user.
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    // MARK: - Create User
    /// Creates a new user with the provided email and password.
    /// - Parameters:
    ///   - email: The user's email address.
    ///   - password: The user's password.
    /// - Throws: An error if the user creation fails.
    /// - Returns: An `AuthDataResultModel` representing the newly created user.
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResults = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResults.user)
    }
    
    // MARK: - Sign In
    /// Signs in a user with the provided email and password.
    /// - Parameters:
    ///   - email: The user's email address.
    ///   - password: The user's password.
    /// - Throws: An error if the sign-in fails.
    /// - Returns: An `AuthDataResultModel` representing the signed-in user.
    func signIn(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    // MARK: - Delete User
    /// Deletes the currently authenticated user.
    /// - Throws: An error if the deletion fails.
    func deleteUser() async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        try await user.delete()
    }
    
    // MARK: - Reset Password
    /// Sends a password reset email to the provided email address.
    /// - Parameter email: The email address of the user.
    /// - Throws: An error if the password reset request fails.
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    // MARK: - Sign Out
    /// Signs out the currently authenticated user.
    /// - Throws: An error if the sign-out fails.
    func signOut() throws {
        try Auth.auth().signOut()
    }
}

extension AuthenticationManager {
    func signInWithGoogle() async throws -> AuthDataResultModel {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            throw URLError(.badServerResponse)
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            throw URLError(.cannotFindHost)
        }

        let googleSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
        let user = googleSignInResult.user

        guard let idToken = user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }

        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }
}
