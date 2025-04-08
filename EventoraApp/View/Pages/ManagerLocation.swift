import Foundation
import CoreLocation
import SwiftUI

class ManagerLocation: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    @Published var placemark: CLPlacemark?
    @Published var isLoading = false
    @Published var error: String?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocation() {
        isLoading = true
        error = nil
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            error = "Location access denied. Please enable location services in Settings."
            isLoading = false
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        @unknown default:
            error = "Unknown location authorization status"
            isLoading = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        case .denied, .restricted:
            error = "Location access denied. Please enable location services in Settings."
            isLoading = false
        case .notDetermined:
            break
        @unknown default:
            error = "Unknown location authorization status"
            isLoading = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        isLoading = false
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            if let error = error {
                self?.error = error.localizedDescription
                return
            }
            self?.placemark = placemarks?.first
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let clError = error as? CLError
        
        switch clError?.code {
        case .locationUnknown, .denied:
            self.error = "Unable to determine location. Please check your settings."
        case .network:
            self.error = "Network error occurred. Please check your connection."
        default:
            self.error = "Failed to get location: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
