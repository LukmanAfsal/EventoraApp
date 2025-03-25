//
//  ProfilePageViewModel.swift
//  EventoraApp
//
//  Created by Abhinand K J on 03/03/25.
//

import FirebaseFirestore
import FirebaseAuth

@MainActor
final class ProfilePageViewModel: ObservableObject {
    @Published var isUserLoggedIn: Bool = false
    @Published var userLoggedOut: Bool = false
    @Published var userData: UserData? = nil
    
    struct UserData: Equatable {
        let name: String
        let email: String
        let profilePicture: String?
        let dateOfBirth: Date?
    }
    
    func checkUserLoggedIn() {
        do {
            let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
            isUserLoggedIn = true
            fetchUserData(uid: authUser.uid)
        } catch {
            isUserLoggedIn = false
        }
    }
    
    func fetchUserData(uid: String) {
        let db = Firestore.firestore()
        db.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("Error fetching user data: \(error.localizedDescription)")
                return
            }
            
            if let data = snapshot?.data() {
                print("Fetched User Data: \(data)")
                
                let name = data["name"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let profilePicture = data["profilePicture"] as? String
                let dateOfBirthTimestamp = data["dateOfBirth"] as? Timestamp
                let dateOfBirth = dateOfBirthTimestamp?.dateValue()
                
                print("Fetched Date of Birth: \(String(describing: dateOfBirth))")
                
                self.userData = UserData(name: name, email: email, profilePicture: profilePicture, dateOfBirth: dateOfBirth)
            }
        }
    }
    
    func saveDateOfBirth(_ date: Date) {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("Error: No authenticated user found.")
            return
        }
        
        let db = Firestore.firestore()
        let userData: [String: Any] = [
            "dateOfBirth": Timestamp(date: date)
        ]
        
        db.collection("users").document(uid).setData(userData, merge: true) { error in
            if let error = error {
                print("Error saving date of birth: \(error.localizedDescription)")
            } else {
                print("Date of Birth saved successfully: \(date)")
            }
        }
    }
    
    func deleteAccount() async {
        do {
            try await AuthenticationManager.shared.deleteUser()
            isUserLoggedIn = false
            userLoggedOut.toggle()
        } catch {
            print("Error deleting account: \(error.localizedDescription)")
        }
    }
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
        isUserLoggedIn = false
        userLoggedOut.toggle()
    }
}
