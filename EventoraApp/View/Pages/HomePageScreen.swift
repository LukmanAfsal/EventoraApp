
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
    
    var body: some View {
        NavigationStack{
            ZStack{
                BackgroundGradient(gradientColor: selectedTab.gradientColor)
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
                        NavigationLink(destination: ProfilePage()) {
                            Image(systemName: "person.crop.circle.fill")
                                .foregroundStyle(.gray)
                                .font(.system(size: 40))
                        }
                    }
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
            }
            .fullScreenCover(isPresented: $isLocationPresented) {
                LocationDetailPage()
            }
        }
    }
}


#Preview {
    HomePageScreen()
}





//struct TabViewContent: View {
//    var selectedTab: AuraTab
//    
//    @ViewBuilder
//    var body: some View {
//        switch selectedTab {
//        case .forYou: ForYouTabView()
//        case .events: EventsTab()
//        case .movies: MoviesTab()
//        case .sport: DiningTab()
//        }
//    }
//}

//struct HomePageScreen: View {
//
//    @State private var selectedTab: AuraTab = .forYou
//    @State private var isLocationPresented = false
//
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                BackgroundGradient(gradientColor: selectedTab.gradientColor)
//
//                VStack {
//                    TopBar(isLocationPresented: $isLocationPresented)
//                    SearchBar(placeholder: selectedTab.searchPlaceHolder)
//
//                    TabViewContent(selectedTab: selectedTab)
//
//                    CustomTabBar(selectedTab: $selectedTab)
//                }
//            }
//            .fullScreenCover(isPresented: $isLocationPresented) {
//                LocationDetailPage()
//            }
//        }
//    }
//}
//
//struct TopBar: View {
//    @Binding var isLocationPresented: Bool
//
//    var body: some View {
//        HStack {
//            Button(action: { isLocationPresented.toggle() }) {
//                HStack {
//                    Image(systemName: "location.circle.fill")
//                        .foregroundStyle(.gray)
//                        .font(.system(size: 35))
//
//                    VStack(alignment: .leading) {
//                        Text("Koratty Infopark")
//                            .font(.system(size: 20))
//                            .bold()
//                            .foregroundStyle(.white)
//                        Text("Koratty, Kerala")
//                            .font(.system(size: 15))
//                            .bold()
//                            .foregroundStyle(.white)
//                    }
//                    Image(systemName: "chevron.down")
//                        .foregroundStyle(.white)
//                        .font(.system(size: 15))
//                        .bold()
//                }
//            }
//
//            Spacer()
//
//            NavigationLink(destination: ProfilePage()) {
//                Image(systemName: "person.crop.circle.fill")
//                    .foregroundStyle(.gray)
//                    .font(.system(size: 40))
//            }
//        }
//        .padding(.horizontal, 15)
//    }
//}
//
//struct SearchBar: View {
//    var placeholder: String
//
//    var body: some View {
//        NavigationLink(destination: SearchPage()) {
//            ZStack {
//                RoundedRectangle(cornerRadius: 20)
//                    .fill(Color.cgray.opacity(0.9))
//                    .frame(width: 375, height: 50)
//                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.cgray2, lineWidth: 2))
//
//                HStack {
//                    Image(systemName: "magnifyingglass")
//                        .foregroundStyle(.gray)
//                    Text(placeholder)
//                        .foregroundStyle(.gray)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                }
//                .padding(.horizontal, 30)
//            }
//        }
//    }
//}
