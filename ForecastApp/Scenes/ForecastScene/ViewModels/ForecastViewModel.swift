//
//  WeatherDataViewModel.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 24/04/2023.
//

import Foundation
import CoreLocation
import Combine

protocol ForecastViewModelProtocol: AnyObject, ObservableObject {
    var state: FetchState { get }
    var searchType: SearchType { get set }
    var currentWeatherViewModel: CurrentWeatherViewModel { get }
    var dataSource: [WeatherRowViewModel] { get }
    func fetchForecast() async
    func validateCaching()
    func getCurrentLocation() async throws
}
