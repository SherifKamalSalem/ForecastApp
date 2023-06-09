//
//  CurrentWeatherRowViewModel.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 26/04/2023.
//

import Foundation
import MapKit

struct CurrentWeatherRowViewModel {
    private let item: CurrentWeatherResponse
    
    var temperature: String {
        return String(format: "%.1f", item.main.temperature)
    }
    
    var maxTemperature: String {
        return String(format: "%.1f", item.main.maxTemperature)
    }
    
    var minTemperature: String {
        return String(format: "%.1f", item.main.minTemperature)
    }
    
    var humidity: String {
        return String(format: "%.1f", item.main.humidity)
    }
    
    var coordinate: CLLocationCoordinate2D {
      return CLLocationCoordinate2D.init(latitude: item.coord.lat, longitude: item.coord.lon)
    }
    
    init(item: CurrentWeatherResponse) {
        self.item = item
    }
}
