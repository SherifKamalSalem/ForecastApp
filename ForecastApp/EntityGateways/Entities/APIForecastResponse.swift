//
//  APIForecastResponse.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 24/04/2023.
//

import Foundation

struct APIForecastResponse: Decodable {
    let list: [APIItem]
}
