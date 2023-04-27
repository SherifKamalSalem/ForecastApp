//
//  FetchCurrentWeatherUseCase.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 26/04/2023.
//

import Foundation

protocol FetchCurrentWeatherUseCase {
    func execute(searchType: SearchType) async throws -> Result<CurrentWeatherResponse>
}


final class DefaultFetchCurrentWeatherUseCase: FetchCurrentWeatherUseCase {
    private let currentWeatherGateway: CurrentWeatherGateway
    
    init(currentWeatherGateway: CurrentWeatherGateway) {
        self.currentWeatherGateway = currentWeatherGateway
    }
    
    func execute(searchType: SearchType) async throws -> Result<CurrentWeatherResponse> {
        return try await currentWeatherGateway.fetchCurrentWeather(searchType: searchType)
    }
}
