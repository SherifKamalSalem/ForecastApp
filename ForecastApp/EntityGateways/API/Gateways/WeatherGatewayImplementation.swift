//
//  WeatherGatewayImplementation.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 25/04/2023.
//

import Foundation

class APIWeatherGatewayImplementation: WeatherGateway {
    let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchWeatherData(searchType: SearchType) async throws -> Result<ForecastResponse> {
        let request = WeatherDataAPIRequest(searchType: searchType)
        let response: Result<APIResponse<APIForecastResponse>> = try await apiClient.execute(request: request)
        let items = try response.get().entity.list.map { $0.itemObject }
        return .success(ForecastResponse(list: items))
    }
}

