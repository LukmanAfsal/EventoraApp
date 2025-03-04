//
//  LocationDetailPage.swift
//  EventoraApp
//
//  Created by jeboy on 14/02/25.
//

import SwiftUI

struct LocationDetailPage: View {
    @Environment(\.dismiss) var dismiss
    @State private var locationName: String = ""
    
    let places = ["Delhi NCR", "Hydrabad", "Kolkata", "Pune", "Goa", "Bangaluru", "Mumbai", "Chandigarh", "Ahmedabadh", "Chennai"]
    let indianCities: [String] = [
        "Mumbai",
        "Delhi",
        "Bangalore",
        "Hyderabad",
        "Chennai",
        "Kolkata",
        "Ahmedabad",
        "Pune",
        "Jaipur",
        "Lucknow",
        "Kochi",
        "Bhopal",
        "Chandigarh",
        "Visakhapatnam",
        "Thiruvananthapuram"
    ]

    
    let columns = [GridItem(.fixed(100)), GridItem(.fixed(100))]

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                
                HStack {
                    Button(action: {dismiss()}) {
                        Image(systemName: "chevron.down")
                            .bold()
                    }
                    .padding()
                    .foregroundStyle(.white)
                    .cornerRadius(8)
                    
                    Text("Location")
                        .bold()
                        .font(.system(size: 25))
                        .foregroundStyle(.white)
                    Spacer()
                                                
                }
                .padding(.horizontal, -2)
                
                TextField(
                    "",
                    text: $locationName,
                    prompt: Text(
                        "Search city,area or locality"
                    ).foregroundStyle(
                        .gray
                    )
                )
                    .padding()
                    .background(Color.cgray)
                    .foregroundStyle(.white)
                    .cornerRadius(15)
                    .padding(.horizontal, 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1)
                            .padding(.horizontal, 10)
                    )
                
//                TextField(text:$locationName) {
//                    Text("loc")
//                        .foregroundStyle(.white)
//                }
//                .foregroundStyle(.white)
                
                Button(action: {}) {
                    HStack {
                        Image(systemName: "location.viewfinder")
                            .bold()
                            .font(.system(size: 23))
                            .foregroundStyle(.white)
                        
                        Text("Use Current Location")
                            .bold()
                            .font(.system(size: 15))
                            .foregroundStyle(.white)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .bold()
                            .font(.system(size: 15))
                            .foregroundStyle(.white)
                    }
                    .padding(.vertical, 15)
                    .padding(.horizontal, 20)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.cgray)
                    )
                    .padding(.top, 13)
                    .padding(.horizontal, 10)
                }
                
                HStack {
                    Text("Popular cities")
                        .bold()
                        .font(.system(size: 19))
                        .foregroundStyle(.white)
                        .padding(.top, 24)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom, -10)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: columns, spacing: 10) {
                        ForEach(places, id: \.self) { place in
                            Text(place)
                                .bold()
                                .foregroundStyle(.white)
                                .frame(width: 120, height: 100)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(10)
                                }
                        }
                            .padding(.horizontal, 10)
                            .padding(.top, 20)
            }
                HStack {
                    Text("All cities")
                        .bold()
                        .font(.system(size: 19))
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding(.top, 24)
                .padding()
                
                
                
                
                
                
                
       
                
    
                Spacer()
            }
        }
    }
}

#Preview {
    LocationDetailPage()
}
