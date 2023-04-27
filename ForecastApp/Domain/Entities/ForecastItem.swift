//
//  ForecastItem.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 23/04/2023.
//

import Foundation

struct Item {
    let date: Date
    let main: MainClass
    let weather: [Weather]
}

struct MainClass {
  let temp: Double
}

struct Weather {
  let main: MainEnum
  let weatherDescription: String
}

enum MainEnum: String {
  case clear = "Clear"
  case clouds = "Clouds"
  case rain = "Rain"
}
