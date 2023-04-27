//
//  APIItem.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 24/04/2023.
//

import Foundation

struct APIItem: Decodable {
    let date: Date
    let main: APIMainClass
    let weather: [APIWeather]
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case main, weather
    }
}

struct APIMainClass: Decodable {
    let temp: Double
}

struct APIWeather: Decodable {
    let main: APIMainEnum
    let weatherDescription: String
    
    enum CodingKeys: String, CodingKey {
        case main
        case weatherDescription = "description"
    }
}

enum APIMainEnum: String, Decodable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

extension APIMainEnum {
    var mainEnum: MainEnum {
        return MainEnum(rawValue: rawValue) ?? .clear
    }
}

extension APIWeather {
    var weatherObject: Weather {
        return Weather(main: main.mainEnum, weatherDescription: weatherDescription)
    }
}

extension APIMainClass {
    var mainObject: MainClass {
        return MainClass(temp: temp)
    }
}

extension APIItem {
    var itemObject: Item {
        return Item(date: date, main: main.mainObject, weather: weather.map { $0.weatherObject })
    }
}
