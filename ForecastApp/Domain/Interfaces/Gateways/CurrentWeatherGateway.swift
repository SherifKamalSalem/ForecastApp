//
//  CurrentWeatherGateway.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 26/04/2023.
//

import Foundation

protocol CurrentWeatherGateway {
    @discardableResult
    func fetchCurrentWeather(searchType: SearchType) async throws -> Result<CurrentWeatherResponse>
}
