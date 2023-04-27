//
//  CurrentWeatherResponse.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 26/04/2023.
//

import Foundation

struct APICurrentWeatherResponse: Decodable {
    let coord: APICoord
    let main: APICurrentWeatherMain
}

struct APICoord: Decodable {
  let lon: Double
  let lat: Double
}

extension APICoord {
    var coord: Coord {
        return Coord(lon: lon, lat: lat)
    }
}

extension APICurrentWeatherResponse {
    var response: CurrentWeatherResponse {
        CurrentWeatherResponse(coord: coord.coord, main: main.main)
    }
}
