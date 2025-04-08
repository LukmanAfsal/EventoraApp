//
//  CheckoutPage.swift
//  EventoraApp
//
//  Updated to fix location detection for Indian addresses
//  Created by Abhinand K J on 25/03/25.
//

import SwiftUI
import CoreLocation

struct CheckoutView: View {
    // MARK: - Environment
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - State
    @State private var fullName: String = ""
    @State private var address: String = ""
    @State private var city: String = ""
    @State private var postalCode: String = ""
    @State private var country: String = "India" // Default to India
    @State private var selectedPayment: PaymentMethod = .creditCard
    @State private var isShowingConfirmation = false
    @State private var isLoadingLocation = false
    @State private var locationError: String?
    
    // MARK: - Parameters
    var ticketPrice: Double
    var seatCount: Int
    
    // MARK: - Models
    enum PaymentMethod: String, CaseIterable {
        case creditCard = "Credit Card"
        case paypal = "PayPal"
        case applePay = "Apple Pay"
        case crypto = "Crypto"
    }
    
    var cartItems: [CartItem] {
        [CartItem(name: "Movie Ticket - Avengers: Endgame", price: ticketPrice/Double(seatCount), quantity: seatCount)]
    }
    
    // MARK: - Location
    @StateObject private var locationManager = LocationManager()
    
    // MARK: - Computed Properties
    var subtotal: Double { ticketPrice }
    var tax: Double { subtotal * 0.08 }
    var total: Double { subtotal + tax }
    
    var body: some View {
        ZStack(alignment: .top) {
            // MARK: - Background
            Color.black.ignoresSafeArea()
            
            // MARK: - Scrollable Content
            ScrollView {
                Spacer().frame(height: 110)
                
                VStack(spacing: 20) {
                    
                    // MARK: - Order Summary Card
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color("cgray"))
                        
                        VStack(alignment: .leading, spacing: 15) {
                            Text("ORDER SUMMARY")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding(.top)
                            
                            ForEach(cartItems) { item in
                                HStack {
                                    Text(item.name)
                                        .foregroundColor(.white)
                                    Spacer()
                                    Text("\(item.quantity) × $\(item.price, specifier: "%.2f")")
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            Divider()
                                .background(Color.gray)
                            
                            PriceRow(label: "Subtotal", value: subtotal)
                            PriceRow(label: "Tax (8%)", value: tax)
                            PriceRow(label: "Total", value: total, isTotal: true)
                        }
                        .padding()
                    }
                    .frame(width: 390)
                    
                    // MARK: - Shipping Details
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Text("SHIPPING DETAILS")
                                .font(.headline)
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            Button(action: fetchCurrentLocation) {
                                HStack {
                                    if isLoadingLocation {
                                        ProgressView()
                                            .tint(.gray)
                                    } else {
                                        Image(systemName: "location.fill")
                                    }
                                    Text("Locate Me")
                                }
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding(8)
                                .background(Color.blue)
                                .cornerRadius(8)
                            }
                            .disabled(isLoadingLocation)
                        }
                        
                        InputField(icon: "person.fill", placeholder: "Full Name", text: $fullName)
                        InputField(icon: "house.fill", placeholder: "Address", text: $address)
                        HStack(spacing: 12) {
                            InputField(icon: "building.2.fill", placeholder: "City", text: $city)
                            InputField(icon: "number", placeholder: "Postal Code", text: $postalCode)
                        }
                        InputField(icon: "globe", placeholder: "Country", text: $country)
                        
                        if let error = locationError {
                            Text(error)
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                    .padding()
                    .background(Color("cgray"))
                    .cornerRadius(12)
                    .frame(width: 390)
                    
                    // MARK: - Payment Methods
                    VStack(alignment: .leading, spacing: 15) {
                        Text("PAYMENT METHOD")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        ForEach(PaymentMethod.allCases, id: \.self) { method in
                            PaymentMethodButton(
                                method: method,
                                isSelected: selectedPayment == method,
                                action: { selectedPayment = method }
                            )
                        }
                    }
                    .padding()
                    .background(Color("cgray"))
                    .cornerRadius(12)
                    .frame(width: 390)
                }
                .padding()
                
                Spacer().frame(height: 110)
            }
            .ignoresSafeArea()
            
            // MARK: - Top Navigation Bar
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundStyle(.white)
                            .font(.system(size: 24))
                    }
                    Spacer()
                    Text("Checkout")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "questionmark.circle")
                            .foregroundStyle(.white)
                            .font(.system(size: 21))
                    }
                }
                .padding()
                .background(
                    BlurView(style: .dark)
                        .ignoresSafeArea()
                )
            }
            
            // MARK: - Bottom Action Bar
            VStack {
                Spacer()
                
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Total Amount")
                            .foregroundStyle(.gray)
                            .bold()
                            .font(.system(size: 16))
                        
                        Text("$\(total, specifier: "%.2f")")
                            .foregroundStyle(.white)
                            .bold()
                            .font(.system(size: 20))
                    }
                    
                    Spacer()
                    
                    Button(action: placeOrder) {
                        Text("Confirm Payment")
                            .padding()
                            .bold()
                            .foregroundColor(.black)
                            .background(isFormValid ? Color.white : Color.gray)
                            .cornerRadius(10)
                            .frame(width: 180)
                    }
                    .disabled(!isFormValid)
                    .shadow(color: isFormValid ? .green : .clear, radius: 5, y: 2)
                }
                .padding(25)
                .background(
                    BlurView(style: .dark)
                        .ignoresSafeArea()
                )
            }
        }
        .navigationBarHidden(true)
        .alert(isPresented: $isShowingConfirmation) {
            Alert(
                title: Text("Order Confirmed"),
                message: Text("Your payment was successful. A receipt has been sent to your email."),
                dismissButton: .default(Text("OK")) {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
    
    // MARK: - Helper Functions
    var isFormValid: Bool {
        !fullName.isEmpty && !address.isEmpty && !city.isEmpty && !postalCode.isEmpty && !country.isEmpty
    }
    
    func placeOrder() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isShowingConfirmation = true
        }
    }
    
    private func fetchCurrentLocation() {
        isLoadingLocation = true
        locationError = nil
        
        locationManager.requestLocation { result in
            isLoadingLocation = false
            
            switch result {
            case .success(let location):
                locationManager.reverseGeocode(location: location) { placemark, error in
                    if let error = error {
                        locationError = "Failed to get address: \(error.localizedDescription)"
                        return
                    }
                    
                    if let placemark = placemark {
                        DispatchQueue.main.async {
                            self.address = [
                                placemark.subThoroughfare,  // House number
                                placemark.thoroughfare      // Street name
                            ].compactMap { $0 }.joined(separator: " ")
                            
                            self.city = placemark.locality ?? placemark.subAdministrativeArea ?? ""
                            self.postalCode = placemark.postalCode ?? ""
                            self.country = placemark.country ?? "India"
                            
                            // Special handling for Indian addresses
                            if self.country == "India" {
                                if let administrativeArea = placemark.administrativeArea {
                                    self.city = "\(self.city), \(administrativeArea)"
                                }
                            }
                        }
                    }
                }
                
            case .failure(let error):
                locationError = error.localizedDescription
            }
        }
    }
}

// MARK: - Subviews
struct PriceRow: View {
    let label: String
    let value: Double
    var isTotal: Bool = false
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(isTotal ? .white : .gray)
                .font(isTotal ? .headline.bold() : .subheadline)
            Spacer()
            Text("$\(value, specifier: "%.2f")")
                .foregroundColor(isTotal ? .white : .gray)
                .font(isTotal ? .headline.bold() : .subheadline)
        }
    }
}

struct InputField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.gray)
                .frame(width: 25)
            TextField(placeholder, text: $text)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

struct PaymentMethodButton: View {
    let method: CheckoutView.PaymentMethod
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(isSelected ? .blue : .gray)
                Text(method.rawValue)
                    .foregroundColor(.gray)
                Spacer()
                if method == .applePay {
                    Image(systemName: "applelogo")
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
    }
}

// MARK: - Models
struct CartItem: Identifiable, Codable {
    let id: UUID
    let name: String
    let price: Double
    let quantity: Int
    
    init(name: String, price: Double, quantity: Int, id: UUID = UUID()) {
        self.id = id
        self.name = name
        self.price = price
        self.quantity = quantity
    }
}

// MARK: - Updated Location Manager
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private var completion: ((Result<CLLocation, Error>) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10
    }
    
    func requestLocation(completion: @escaping (Result<CLLocation, Error>) -> Void) {
        self.completion = completion
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                switch self.locationManager.authorizationStatus {
                case .notDetermined:
                    self.locationManager.requestWhenInUseAuthorization()
                case .authorizedWhenInUse, .authorizedAlways:
                    self.locationManager.startUpdatingLocation()
                case .denied, .restricted:
                    completion(.failure(CLError(.denied)))
                @unknown default:
                    completion(.failure(CLError(.denied)))
                }
            } else {
                completion(.failure(CLError(.locationUnknown)))
            }
        }
    }
    
    func reverseGeocode(location: CLLocation, completion: @escaping (CLPlacemark?, Error?) -> Void) {
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "en_IN") // Force Indian locale
        
        geocoder.reverseGeocodeLocation(location, preferredLocale: locale) { placemarks, error in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                // Fallback to default geocoding if Indian locale fails
                geocoder.reverseGeocodeLocation(location) { placemarks, error in
                    DispatchQueue.main.async {
                        completion(placemarks?.first, error)
                    }
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(placemarks?.first, nil)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        print("Location received - Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
        print("Accuracy: \(location.horizontalAccuracy) meters")
        
        if location.horizontalAccuracy < 100 {
            manager.stopUpdatingLocation()
            completion?(.success(location))
            completion = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
        manager.stopUpdatingLocation()
        completion?(.failure(error))
        completion = nil
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            manager.startUpdatingLocation()
        } else if let completion = completion {
            completion(.failure(CLError(.denied)))
            self.completion = nil
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CheckoutView(ticketPrice: 59.95, seatCount: 3)
    }
}
