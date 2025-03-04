
//
//  HomePageScreen.swift
//  EventoraApp
//
//  Created by jeboy on 13/02/25.
//

import SwiftUI

struct HomePageScreen: View {
    
    @State private var selectedTab: AuraTab = .forYou
    @State private var isLocationPresented = false
    @State private var showSignInView: Bool = false
    @EnvironmentObject private var router :Router
    @AppStorage("skippedOnboarding") var skippedOnboarding: Bool = false
    @AppStorage("isloggedin") var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationStack(path: $router.navPath) {
            ZStack{
                BackgroundRadient(gradientColor: selectedTab.gradientColor)
                VStack {
                    HStack {
                        Button(action: {
                            isLocationPresented.toggle()
                        }) {
                            HStack{
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
                        Button(action: {
                            router.navigate(to: .profile)
                        }) {
                            Image(systemName: "person.crop.circle.fill")
                                .foregroundStyle(.gray)
                                .font(.system(size: 40))
                        }}
                    .padding(.horizontal,15)
                    
                    NavigationLink(destination: SearchPage()) {
                        ZStack{
                            Rectangle()
                                .frame(width: 375, height: 50)
                                .foregroundStyle(.cgray.opacity(0.9))
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.cgray2, lineWidth: 2)
                                )
                            
                            HStack{
                                Image(systemName: "magnifyingglass")
                                    .foregroundStyle(.gray)
                                Text(selectedTab.searchPlaceHolder)
                                    .foregroundStyle(.gray)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(.horizontal, 30)
                        }
                    }
                    
                    VStack(spacing: 0) {
                        switch selectedTab {
                        case .forYou: ForYouTabView()
                        case .events: EventsTab()
                        case .movies: MoviesTab()
                        case .sport: DiningTab()
                        }
                        
                        CustomTabBar(selectedTab: $selectedTab)
                    }
                }
                .onAppear{
                    let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
                    //self.showSignInView = authUser == nil ? true : false
                    
                }
                
                if (isLoggedIn == false && skippedOnboarding  == false) && skippedOnboarding == false {
                    
                    LoginScreen(skippedOnboarding: $skippedOnboarding, loginSuccessful: $isLoggedIn)
                    
                }
            }
            .fullScreenCover(isPresented: $isLocationPresented){
                LocationDetailPage()
            }
            .toolbarVisibility(.hidden, for: .navigationBar)
            .navigationDestination(for: NavDestination.self) { destination in
                switch destination {
                case .login:
                    LoginScreen(skippedOnboarding: $skippedOnboarding,loginSuccessful: $isLoggedIn)
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


#Preview {
    HomePageScreen()
        .environmentObject(Router())
}
