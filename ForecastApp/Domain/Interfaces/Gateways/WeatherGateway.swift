//
//  WeatherGateway.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 23/04/2023.
//

import Foundation

protocol WeatherGateway {
    @discardableResult
    func fetchWeatherData(searchType: SearchType) async throws -> Result<ForecastResponse>
}
