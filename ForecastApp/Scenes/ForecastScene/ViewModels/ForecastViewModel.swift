//
//  WeatherDataViewModel.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 24/04/2023.
//

import Foundation
import CoreLocation
import Combine

protocol ForecastViewModelProtocol: AnyObject, ObservableObject {
    var state: FetchState { get }
    var searchType: SearchType { get set }
    var currentWeatherViewModel: CurrentWeatherViewModel { get }
    var dataSource: [WeatherRowViewModel] { get }
    func fetchForecast() async
    func validateCaching()
    func getCurrentLocation() async throws
}

class ForecastViewModel: NSObject, ForecastViewModelProtocol {
    @Published var dataSource: [WeatherRowViewModel] = []
    @Published var state: FetchState = .ideal
    @Published var searchType: SearchType = .cityName(city: "")
    
    private let locationManager = CLLocationManager()
    
    var currentWeatherViewModel: CurrentWeatherViewModel {
        CurrentWeatherViewModel(usecase: currentWeatherUsecase)
    }
    
    private let usecase: FetchWeatherDataUseCase
    private let currentWeatherUsecase: FetchCurrentWeatherUseCase
    
    init(usecase: FetchWeatherDataUseCase, currentWeatherUsecase: FetchCurrentWeatherUseCase) {
        self.usecase = usecase
        self.currentWeatherUsecase = currentWeatherUsecase
        super.init()
        validateCaching()
    }
    
    func fetchForecast() async {
        DispatchQueue.main.async {
            self.state = .loading
        }
        do {
            let response: Result<ForecastResponse>
            switch searchType {
            case .cityName(let city):
                response = try await usecase.execute(searchType: .cityName(city: city))
            case .zipCode(let zipCode):
                response = try await usecase.execute(searchType: .zipCode(zipCode: zipCode))
            case .latitudeLongitude(let lat, let lon):
                response = try await usecase.execute(searchType: .latitudeLongitude(lat: lat, lon: lon))
            }
            updateWeatherData(dataSource: try response.get().list.map { WeatherRowViewModel(item: $0) }, state: .finished)
            storeLastSearchedType(searchType)
        } catch {
            updateWeatherData(dataSource: [], state: .showError(error: error))
        }
    }
    
    func validateCaching() {
        guard let dictionary = UserDefaults.standard.dictionary(forKey: Constants.lastSeachedType),
              let dict = dictionary.compactMapValues({ $0 }).first,
              let value = dict.value as? String else { return }
        switch dict.key {
        case "city":
            self.searchType = .cityName(city: value)
        case "zipCode":
            self.searchType = .zipCode(zipCode: value)
        case "location":
            self.searchType = .zipCode(zipCode: value)
        default:
            break
        }
    }
    
    private func updateWeatherData(
        dataSource: [WeatherRowViewModel],
        state: FetchState) {
            DispatchQueue.main.async {
                self.dataSource = dataSource
                self.state = state
        }
    }
    
    func getCurrentLocation() async throws {
        guard CLLocationManager.locationServicesEnabled() else {
            throw NSError()
        }
        
        let authorizationStatus = CLLocationManager.authorizationStatus()
        
        switch authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestLocation()
        case .denied, .restricted:
            throw NSError()
        case .notDetermined:
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            throw NSError()
        }
    }
    
    func storeLastSearchedType(_ searchType: SearchType) {
        var dict = [String: String]()
        switch searchType {
        case .cityName(let city):
            dict["city"] = city
            dict["zipCode"] = nil
            dict["location"] = nil
        case .zipCode(let zipCode):
            dict["zipCode"] = zipCode
            dict["city"] = nil
            dict["location"] = nil
        case .latitudeLongitude(let lat, let lon):
            dict["location"] = "\(lat),\(lon)"
            dict["city"] = nil
            dict["zipCode"] = nil
        }
        UserDefaults.standard.set(dict, forKey: Constants.lastSeachedType)
    }
}

enum SearchType: Equatable, CaseIterable, Hashable, Identifiable {
    var id: Self {
        return self
    }
    
    case cityName(city: String)
    case zipCode(zipCode: String)
    case latitudeLongitude(lat: Double, lon: Double)
    
    var placeholder: String {
        switch self {
        case .cityName:
            return "City name"
        case .zipCode:
            return "Zip code"
        case .latitudeLongitude:
            return "Latitude, longitude"
        }
    }
    
    var value: String {
        switch self {
        case .cityName(let city):
            return city
        case .zipCode(let zipCode):
            return zipCode
        case .latitudeLongitude(let lat, let lon):
            return "\(lat), \(lon)"
        }
    }
    
    static var allCases: [SearchType] {
        return [.cityName(city: ""), .zipCode(zipCode: ""), .latitudeLongitude(lat: 0.0, lon: 0.0)]
    }
}


extension ForecastViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.searchType = .latitudeLongitude(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
        var dict = [String: String]()
        dict["location"] = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
        dict["city"] = nil
        dict["zipCode"] = nil
        UserDefaults.standard.set(dict, forKey: Constants.lastSeachedType)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: \(error.localizedDescription)")
    }
}
