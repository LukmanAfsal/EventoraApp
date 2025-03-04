//
//  ForYouViewModel.swift
//  EventoraApp
//
//  Created by Abhinand K J on 04/03/25.
//


import Foundation

class ForYouViewModel: ObservableObject {
    @Published var eventResponse: EventResponse?
    
//    init() {
//        loadEvents()
//    }
    
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
    

    
    func loadEvents() {
        guard let url = URL(string: "https://run.mocky.io/v3/62618c4c-3829-4f28-995b-d663b5d37ae3") else {
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




//    let urlString = "https://run.mocky.io/v3/62618c4c-3829-4f28-995b-d663b5d37ae3"
//
//    func loadEvents(from urlString: String, completion: @escaping (EventResponse?) -> Void) {
//        guard let url = URL(string: urlString) else {
//            print("Invalid URL")
//            completion(nil)
//            return
//        }

