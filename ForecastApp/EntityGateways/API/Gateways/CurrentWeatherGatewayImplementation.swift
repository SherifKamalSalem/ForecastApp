//
//  CurrentWeatherGatewayImplementation.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 26/04/2023.
//

import Foundation

class APICurrentWeatherGatewayImplementation: CurrentWeatherGateway {
    let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchCurrentWeather(searchType: SearchType) async throws -> Result<CurrentWeatherResponse> {
        let request = CurrentWeatherAPIRequest(searchType: searchType)
        let response: Result<APIResponse<APICurrentWeatherResponse>> = try await apiClient.execute(request: request)
        let entity = try response.get().entity
        return .success(entity.response)
    }
}
