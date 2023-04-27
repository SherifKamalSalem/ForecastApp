//
//  WeatherDataView.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 25/04/2023.
//

import SwiftUI

struct ForecastView<ViewModel: ForecastViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            List {
                Button("Current Location") {
                    Task {
                        try? await viewModel.getCurrentLocation()
                    }
                }
                switch viewModel.state {
                case .loading:
                    ProgressView()
                case .empty:
                    emptySection
                case .finished:
                    lastSearchedLocationSection
                    forecastSection
                default:
                    emptySection
                }
            }
            .searchable(text: searchTextBinding, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search by \(viewModel.searchType.placeholder)")
            .onChange(of: viewModel.searchType) { searchableText in
                Task {
                    await viewModel.fetchForecast()
                }
            }
            .navigationTitle("Forecast")
            .toolbar {
                searchTypeMenu
            }
        }
        .onAppear {
            Task {
                viewModel.validateCaching()
                await viewModel.fetchForecast()
            }
        }
    }
    
    private var searchTextBinding: Binding<String> {
        return Binding<String>(
            get: {
                switch viewModel.searchType {
                case .cityName(let city):
                    return city
                case .zipCode(let zipCode):
                    return zipCode
                case let .latitudeLongitude(lat, lon):
                    return "\(lat),\(lon)"
                }
            },
            set: {
                switch viewModel.searchType {
                case .cityName:
                    viewModel.searchType = .cityName(city: $0)
                case .zipCode:
                    viewModel.searchType = .zipCode(zipCode: $0)
                case let .latitudeLongitude(lat, lon):
                    viewModel.searchType = .latitudeLongitude(lat: lat, lon: lon)
                }
            }
        )
    }
}

private extension ForecastView {
    
    var searchTypeMenu: some View {
        Picker("Search Type", selection: $viewModel.searchType) {
            ForEach(SearchType.allCases) { searchType in
                Text(searchType.placeholder).tag(searchType)
            }
        }
        .padding(.horizontal)
    }
    
    
    
    var forecastSection: some View {
        Section {
            ForEach(viewModel.dataSource, content: ForecastRowView.init(viewModel:))
        }
    }
    
    var lastSearchedLocationSection: some View {
        Section {
            NavigationLink(destination: CurrentWeatherView(viewModel: viewModel.currentWeatherViewModel)) {
                VStack(alignment: .leading) {
                    Text(viewModel.searchType.value)
                    Text("Weather today")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
    }
    
    var emptySection: some View {
        Section {
            Text("No weather data available")
                .foregroundColor(.gray)
        }
    }
}


