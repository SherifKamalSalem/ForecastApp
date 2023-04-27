//
//  WeatherDataRowView.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 26/04/2023.
//

import SwiftUI

struct ForecastRowView: View {
    private let viewModel: WeatherRowViewModel
    
    init(viewModel: WeatherRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(UIColor.secondarySystemBackground))
                .shadow(color: Color(UIColor.systemGray3), radius: 3, x: 0, y: 2)
            
            HStack(alignment: .center, spacing: 20) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(viewModel.title)")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.bottom, 2)
                    
                    Text("\(viewModel.fullDescription)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 5) {
                    Text("\(viewModel.temperature)°")
                        .font(.system(size: 30, weight: .medium, design: .default))
                        .foregroundColor(.primary)
                    
                    Text("\(viewModel.day) \(viewModel.month)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
        }
        .frame(height: 100)
        .accessibilityElement()
        .accessibility(label: Text("\(viewModel.title), \(viewModel.fullDescription), \(viewModel.temperature) degrees"))
        .accessibility(value: Text("\(viewModel.day) \(viewModel.month)"))
    }
}
