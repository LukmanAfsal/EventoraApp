//
//  EventoraAppApp.swift
//  EventoraApp
//
//  Created by jeboy on 11/02/25.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct EventoraAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var router = Router()
    
    var body: some Scene {
        WindowGroup {
            
            //                if isUserLoggedIn() {
            
            HomePageScreen()
                .environmentObject(router)
            //                } else {
            //                    LoginScreen()
            //                        .environmentObject(router)
            //                }
            
        }
    }
}

// Function to check if the user is logged in
//public func isUserLoggedIn() -> Bool {
//    do {
//        _ = try AuthenticationManager.shared.getAuthenticatedUser()
//        return true
//    } catch {
//        return false
//    }
//}
