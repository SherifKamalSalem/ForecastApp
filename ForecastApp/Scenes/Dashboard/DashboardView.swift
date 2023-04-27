//
//  DashboardView.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 26/04/2023.
//

import SwiftUI

struct DashboardView<CurrentWeatherViewModel: CurrentWeatherViewModelProtocol, WeatherDataViewModel: ForecastViewModelProtocol>: View {
    @StateObject private var currentWeatherViewModel: CurrentWeatherViewModel
    private let weatherViewModel: WeatherDataViewModel
    
    init(currentWeatherViewModel: CurrentWeatherViewModel, weatherDataViewModel: WeatherDataViewModel) {
        _currentWeatherViewModel = StateObject(wrappedValue: currentWeatherViewModel)
        self.weatherViewModel = weatherDataViewModel
    }
    
    var body: some View {
        NavigationStack {
            List {
                if let viewModel = currentWeatherViewModel.dataSource {
                    CurrentWeatherRowView(viewModel: viewModel)
                } else {
                    emptySection
                }
                ForecastNavigationLink
                CurrentWeatherNavigationLink
            }
            .navigationTitle("Dashboard")
            .task {
                await currentWeatherViewModel.fetchCurrentWeather()
            }
        }
    }
    
    private var ForecastNavigationLink: some View {
        Section {
            NavigationLink(destination: ForecastView(viewModel: weatherViewModel)) {
                Text("Forecast")
            }
        }
        .padding(.horizontal)
    }
    
    private var CurrentWeatherNavigationLink: some View {
        Section {
            NavigationLink(destination: CurrentWeatherView(viewModel: currentWeatherViewModel)) {
                Text("Current Weather")
            }
        }
        .padding(.horizontal)
    }
}

private extension DashboardView {
    
    var emptySection: some View {
        Section {
            Text("No weather data available")
                .foregroundColor(.gray)
        }
    }
}


