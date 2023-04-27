//
//  CurrentWeatherMain.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 26/04/2023.
//

import Foundation

struct APICurrentWeatherMain: Codable {
    let temperature: Double
    let humidity: Int
    let maxTemperature: Double
    let minTemperature: Double
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case humidity
        case maxTemperature = "temp_max"
        case minTemperature = "temp_min"
    }
}

extension APICurrentWeatherMain {
    var main: CurrentWeatherMain {
        CurrentWeatherMain(temperature: temperature, humidity: humidity, maxTemperature: maxTemperature, minTemperature: minTemperature)
    }
}
