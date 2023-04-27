//
//  CurrentWeatherViewModel.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 26/04/2023.
//

import Foundation

protocol CurrentWeatherViewModelProtocol: AnyObject, ObservableObject {
    var state: FetchState { get }
    var searchType: SearchType { get set }
    var dataSource: CurrentWeatherRowViewModel? { get }
    func validateCaching()
    func fetchCurrentWeather() async
}

class CurrentWeatherViewModel: CurrentWeatherViewModelProtocol {
    
    @Published var searchType: SearchType = .cityName(city: "")
    @Published var dataSource: CurrentWeatherRowViewModel?
    @Published var state: FetchState = .ideal
    
    private let usecase: FetchCurrentWeatherUseCase
    
    init(usecase: FetchCurrentWeatherUseCase) {
        self.usecase = usecase
        validateCaching()
    }
    
    func validateCaching() {
        guard let dictionary = UserDefaults.standard.dictionary(forKey: Constants.lastSeachedType),
              let dict = dictionary.compactMapValues({ $0 }).first,
              let value = dict.value as? String else { return }
        switch dict.key {
        case "city":
            self.searchType = .cityName(city: value)
        case "zipCode":
            self.searchType = .zipCode(zipCode: value)
        case "location":
            self.searchType = .zipCode(zipCode: value)
        default:
            break
        }
    }
    
    func fetchCurrentWeather() async {
        DispatchQueue.main.async {
            self.state = .loading
        }
        do {
            let response = try await usecase.execute(searchType: searchType)
            let item = try response.get()
            let currentViewModel = CurrentWeatherRowViewModel(item: item)
            updateWeatherData(dataSource: currentViewModel, state: .finished)
        } catch {
            updateWeatherData(dataSource: nil, state: .showError(error: error))
        }
    }
    
    private func updateWeatherData(
        dataSource: CurrentWeatherRowViewModel?,
        state: FetchState) {
            DispatchQueue.main.async {
                self.dataSource = dataSource
                self.state = state
            }
    }
}

