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
