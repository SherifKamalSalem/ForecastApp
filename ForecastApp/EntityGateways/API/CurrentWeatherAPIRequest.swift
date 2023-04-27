//
//  CurrentWeatherAPIRequest.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 26/04/2023.
//

import Foundation

struct CurrentWeatherAPIRequest: APIRequest {
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    private let appID: String
    private let searchType: SearchType
    
    init(searchType: SearchType, appID: String? = SecretsUtility.appID.value) {
        self.searchType = searchType
        self.appID = appID ?? ""
    }
    
    var urlRequest: URLRequest {
        let urlComponents = makeComponents()
        let url: URL = urlComponents.url!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    func makeComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org/data/2.5/"
        components.path = components.host! + "/weather"
        
        var queryItems = [URLQueryItem]()
        switch searchType {
        case .cityName(let city):
            queryItems.append(URLQueryItem(name: "q", value: city))
        case .zipCode(let zipCode):
            queryItems.append(URLQueryItem(name: "zip", value: zipCode))
        case .latitudeLongitude(let lat, let lon):
            queryItems.append(URLQueryItem(name: "lat", value: String(lat)))
            queryItems.append(URLQueryItem(name: "lon", value: String(lon)))
        }
        queryItems.append(contentsOf: [
            URLQueryItem(name: "mode", value: "json"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "APPID", value: appID)
        ])
        components.queryItems = queryItems
        return components
    }
}

