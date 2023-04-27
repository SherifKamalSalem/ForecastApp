//
//  CurrentWeatherView.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 26/04/2023.
//

import SwiftUI

struct CurrentWeatherView<ViewModel: CurrentWeatherViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    
    var body: some View {
        List(content: content)
            .navigationBarTitle(viewModel.searchType.value)
            .listStyle(GroupedListStyle())
            .task {
                viewModel.validateCaching()
                await viewModel.fetchCurrentWeather()
            }
    }
    
}
private extension CurrentWeatherView {
    func content() -> some View {
        if let viewModel = viewModel.dataSource {
            return AnyView(details(for: viewModel))
        } else {
            return AnyView(loading)
        }
    }
    
    func details(for viewModel: CurrentWeatherRowViewModel) -> some View {
        CurrentWeatherRowView(viewModel: viewModel)
    }
    
    var loading: some View {
        Text("Loading \(viewModel.searchType.value)'s weather...")
            .foregroundColor(.gray)
    }
}
    
