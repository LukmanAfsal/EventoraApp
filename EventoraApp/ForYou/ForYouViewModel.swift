//
//  ForYouViewModel.swift
//  EventoraApp
//
//  Created by Abhinand K J on 04/03/25.
//

import Foundation

// MARK: - ForYouViewModel
class ForYouViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var eventResponse: EventResponse?
    
    // MARK: - Load Events (Local JSON)
    
//    init() {
//        loadEvents()
//    }
//    
//    func loadEvents() {
//        if let url = Bundle.main.url(forResource: "ForYouJson", withExtension: "json") {
//            do {
//                let data = try Data(contentsOf: url)
//                let decodedData = try JSONDecoder().decode(EventResponse.self, from: data)
//                DispatchQueue.main.async {
//                    self.eventResponse = decodedData
//                }
//                print("Successfully loaded JSON data")
//            } catch {
//                print("Error decoding JSON: \(error.localizedDescription)")
//            }
//        } else {
//            print("Failed to find ForYouJson.json in bundle")
//        }
//    }
//}
    
    
    // MARK: - Load Events (API)
    /// Fetches event data from the API and updates the `eventResponse` property.
    func loadEvents() {

        guard let url = URL(string: "https://run.mocky.io/v3/ff2b93da-e565-4429-92e6-38fffd8944a3") else { 
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(EventResponse.self, from: data)
                DispatchQueue.main.async {
                    self.eventResponse = decodedData
                }
                print("Successfully loaded API data")
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}
