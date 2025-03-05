//
//  HomePageScreen.swift
//  EventoraApp
//
//  Created by Abhinand K J on 13/02/25.
//

import SwiftUI

// MARK: - HomePageScreen View
struct HomePageScreen: View {
    
    // MARK: - State Properties
    @State private var selectedTab: AuraTab = .forYou
    @State private var isLocationPresented = false
    @State private var showSignInView: Bool = false
    
    // MARK: - EnvironmentObject
    @EnvironmentObject private var router: Router
    
    // MARK: - AppStorage Properties
    @AppStorage("skippedOnboarding") var skippedOnboarding: Bool = false
    @AppStorage("isloggedin") var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationStack(path: $router.navPath) {
            ZStack {
                // MARK: - Background Gradient
                BackgroundRadient(gradientColor: selectedTab.gradientColor)
                
                VStack {
                    // MARK: - Header
                    HStack {
                        // Location Button
                        Button(action: {
                            isLocationPresented.toggle()
                        }) {
                            HStack {
                                Image(systemName: "location.circle.fill")
                                    .foregroundStyle(.gray)
                                    .font(.system(size: 35))
                                
                                VStack(alignment: .leading) {
                                    Text("Koratty Infopark")
                                        .font(.system(size: 20))
                                        .bold()
                                        .foregroundStyle(.white)
                                    Text("Koratty, Kerala")
                                        .font(.system(size: 15))
                                        .bold()
                                        .foregroundStyle(.white)
                                }
                                
                                Image(systemName: "chevron.down")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 15))
                                    .bold()
                            }
                        }
                        
                        Spacer()
                        
                        // Profile Button
                        Button(action: {
                            router.navigate(to: .profile)
                        }) {
                            Image(systemName: "person.crop.circle.fill")
                                .foregroundStyle(.gray)
                                .font(.system(size: 40))
                        }
                    }
                    .padding(.horizontal, 15)
                    
                    // MARK: - Search Bar
                    NavigationLink(destination: SearchPage()) {
                        ZStack {
                            Rectangle()
                                .frame(width: 375, height: 50)
                                .foregroundStyle(.cgray.opacity(0.9))
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.cgray2, lineWidth: 2)
                                )
                            
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundStyle(.gray)
                                Text(selectedTab.searchPlaceHolder)
                                    .foregroundStyle(.gray)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(.horizontal, 30)
                        }
                    }
                    
                    // MARK: - Tab Content
                    VStack(spacing: 0) {
                        switch selectedTab {
                        case .forYou: ForYouTabView()
                        case .events: EventsTab()
                        case .movies: MoviesTab()
                        case .sport: DiningTab()
                        }
                        
                        // MARK: - Custom Tab Bar
                        CustomTabBar(selectedTab: $selectedTab)
                    }
                }
                .onAppear {
                    // MARK: - Authentication Check
                    let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
                    // self.showSignInView = authUser == nil ? true : false
                }
                
                // MARK: - Login Screen Overlay
                if (isLoggedIn == false && skippedOnboarding == false) && skippedOnboarding == false {
                    LoginScreen(skippedOnboarding: $skippedOnboarding, loginSuccessful: $isLoggedIn)
                }
            }
            // MARK: - Full Screen Cover for Location Detail
            .fullScreenCover(isPresented: $isLocationPresented) {
                LocationDetailPage()
            }
            .toolbarVisibility(.hidden, for: .navigationBar)
            
            // MARK: - Navigation Destinations
            .navigationDestination(for: NavDestination.self) { destination in
                switch destination {
                case .login:
                    LoginScreen(skippedOnboarding: $skippedOnboarding, loginSuccessful: $isLoggedIn)
                case .signUp:
                    SignUpPage()
                case .home:
                    HomePageScreen()
                case .profile:
                    ProfilePage()
                }
            }
        }
        .environmentObject(router)
    }
}

// MARK: - Preview
#Preview {
    HomePageScreen()
        .environmentObject(Router())
}
