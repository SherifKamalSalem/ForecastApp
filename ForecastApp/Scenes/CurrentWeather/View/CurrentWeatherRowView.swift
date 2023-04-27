//
//  CurrentWeatherView.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 26/04/2023.
//

import SwiftUI
import MapKit

struct CurrentWeatherRowView: View {
    private let viewModel: CurrentWeatherRowViewModel
    
    init(viewModel: CurrentWeatherRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            MapView(coordinate: viewModel.coordinate)
                .cornerRadius(25)
                .frame(height: 300)
                .disabled(true)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "thermometer")
                    Text("Temperature:")
                        .font(.body)
                    Text("\(viewModel.temperature)°C")
                        .foregroundColor(.red)
                        .font(.body)
                }
                
                HStack {
                    Image(systemName: "arrow.up.circle")
                    Text("Max Temperature:")
                        .font(.body)
                    Text("\(viewModel.maxTemperature)°C")
                        .foregroundColor(.red)
                        .font(.body)
                }
                
                HStack {
                    Image(systemName: "arrow.down.circle")
                    Text("Min Temperature:")
                        .font(.body)
                    Text("\(viewModel.minTemperature)°C")
                        .foregroundColor(.red)
                        .font(.body)
                }
                
                HStack {
                    Image(systemName: "cloud.drizzle.fill")
                    Text("Humidity:")
                        .font(.body)
                    Text("\(viewModel.humidity)%")
                        .foregroundColor(.blue)
                        .font(.body)
                }
            }
            .padding(.horizontal)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 2)
    }
}
