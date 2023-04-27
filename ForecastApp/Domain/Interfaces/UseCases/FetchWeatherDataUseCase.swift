//
//  FetchWeatherDataUseCase.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 24/04/2023.
//

import Foundation

protocol FetchWeatherDataUseCase {
    func execute(searchType: SearchType) async throws -> Result<ForecastResponse>
}


final class DefaultFetchRestaurantsUseCase: FetchWeatherDataUseCase {

    private let weatherGateway: WeatherGateway
    
    init(weatherGateway: WeatherGateway) {
        self.weatherGateway = weatherGateway
    }
    
    func execute(searchType: SearchType) async throws -> Result<ForecastResponse> {
        return try await weatherGateway.fetchWeatherData(searchType: searchType)
    }
}
