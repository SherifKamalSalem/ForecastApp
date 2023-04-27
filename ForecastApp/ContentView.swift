//
//  ContentView.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 23/04/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let cachedDictionary = UserDefaults.standard.dictionary(forKey: Constants.lastSeachedType)
        
        let currentWeatherUseCase = DefaultFetchCurrentWeatherUseCase(currentWeatherGateway: APICurrentWeatherGatewayImplementation(apiClient: ApiClientImplementation(urlSession: URLSession.shared)))
        DashboardView(currentWeatherViewModel: CurrentWeatherViewModel(usecase: currentWeatherUseCase), weatherDataViewModel: ForecastViewModel(usecase: DefaultFetchRestaurantsUseCase(weatherGateway: APIWeatherGatewayImplementation(apiClient: ApiClientImplementation(urlSession: URLSession.shared))), currentWeatherUsecase: currentWeatherUseCase))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
