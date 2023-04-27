//
//  CurrentWeatherResponse.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 26/04/2023.
//

import Foundation

struct CurrentWeatherResponse {
    let coord: Coord
    let main: CurrentWeatherMain
}

struct Coord {
  let lon: Double
  let lat: Double
}
