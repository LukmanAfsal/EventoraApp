//
//  HomePageScreen.swift
//  EventoraApp
//
//  Created by Abhinand K J on 13/02/25.
//

import SwiftUI
import CoreLocation

struct HomePageScreen: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var locationManager: ManagerLocation
    
    @State private var selectedTab: AuraTab = .forYou
    @State private var isLocationPresented = false
    @State private var showSignInView: Bool = false
    
    @State private var currentLocationName: String = "Current Location"
    @State private var currentLocationArea: String = "Searching...."
    
    @AppStorage("skippedOnboarding") var skippedOnboarding: Bool = false
    @AppStorage("isloggedin") var isLoggedIn: Bool = false
    @AppStorage("savedLocationName") var savedLocationName: String = ""
    @AppStorage("savedLocationArea") var savedLocationArea: String = ""
    
    var body: some View {
        NavigationStack(path: $router.navPath) {
            ZStack {
                BackgroundRadient(gradientColor: selectedTab.gradientColor)
                
                VStack {
                    // Header
                    HStack {
                        Button(action: {
                            isLocationPresented.toggle()
                        }) {
                            HStack {
                                Image(systemName: "location.circle.fill")
                                    .foregroundStyle(.gray)
                                    .font(.system(size: 35))
                                
                                VStack(alignment: .leading) {
                                    Text(currentLocationName)
                                        .font(.system(size: 20))
                                        .bold()
                                        .foregroundStyle(.white)
                                    Text(currentLocationArea)
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
                        
                        Button(action: {
                            router.navigate(to: .profile)
                        }) {
                            Image(systemName: "person.crop.circle.fill")
                                .foregroundStyle(.gray)
                                .font(.system(size: 40))
                        }
                    }
                    .padding(.horizontal, 15)
                    
                    // Search Bar
                    Button(action: {router.navigate(to: .searchpage)}) {
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
                    
                    // Tab Content
                    VStack(spacing: 0) {
                        switch selectedTab {
                        case .forYou: ForYouTabView()
                        case .events: EventsTab()
                        case .techAndBusiness: TechAndBusiness()
                        case .sport:  Sports()
                        }
                        
                        CustomTabBar(selectedTab: $selectedTab)
                    }
                }
                .onAppear {
                    let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
                    
                    // Load saved location if available
                    if !savedLocationName.isEmpty {
                        currentLocationName = savedLocationName
                        currentLocationArea = savedLocationArea
                    }
                }
                
                if (isLoggedIn == false && skippedOnboarding == false) && skippedOnboarding == false {
                    LoginScreen(skippedOnboarding: $skippedOnboarding, loginSuccessful: $isLoggedIn)
                }
            }
            .fullScreenCover(isPresented: $isLocationPresented) {
                LocationDetailPage()
                    .environmentObject(router)
                    .environmentObject(locationManager)
            }
            .onChange(of: locationManager.placemark) { newPlacemark in
                if let placemark = newPlacemark {
                    updateLocationDisplay(with: placemark)
                }
            }
            .toolbarVisibility(.hidden, for: .navigationBar)
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
                case .forgotPassword:
                    ForgotPassPage()
                case .searchpage:
                    SearchPage()
                }
            }
        }
        .environmentObject(router)
    }
    
    private func updateLocationDisplay(with placemark: CLPlacemark) {
        let name = placemark.name ?? "Current Location"
        let area = [
            placemark.locality,
            placemark.administrativeArea
        ].compactMap { $0 }.joined(separator: ", ")
        
        currentLocationName = name
        currentLocationArea = area
        
        // Save to UserDefaults
        savedLocationName = name
        savedLocationArea = area
    }
}

#Preview {
    HomePageScreen()
        .environmentObject(Router())
        .environmentObject(ManagerLocation())
}
