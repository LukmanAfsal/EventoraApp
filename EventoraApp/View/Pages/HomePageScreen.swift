
//
//  HomePageScreen.swift
//  EventoraApp
//
//  Created by jeboy on 13/02/25.
//

import SwiftUI

struct HomePageScreen: View {
    var body: some View {
        NavigationStack{
            ZStack{
                ForYouColor()
                VStack {
                    HStack {
                        NavigationLink(destination: LocationDetailPage()){
                            HStack{
                                Image(systemName: "location.circle.fill")
                                    .foregroundStyle(.gray)
                                    .font(.system(size: 35))
                                
                                VStack {
                                    Text("Koratty Infopark")
                                        .font(.system(size: 20))
                                        .bold()
                                        .foregroundStyle(.white)
                                    Text("Koratty, Kerala")
                                        .font(.system(size: 15))
                                    //                        .multilineTextAlignment(.leading)
                                        .bold()
                                        .foregroundStyle(.white)
                                        .padding(.trailing, 40)
                                }
                                Image(systemName: "chevron.down")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 15))
                                    .bold()
                                    .padding(.bottom)
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
                                Text("Search your event here")
                                    .foregroundStyle(.gray)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(.horizontal, 30)
                        }
                    }
                    
                    TabView{
                        ScrollView{
                            ForYouTabView()
                                .tabItem{
                                    Text("Log")
                                }}
                        
                    }
                    
                }
            }
            
        }
    }
}

#Preview {
    HomePageScreen()
}
