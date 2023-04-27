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
