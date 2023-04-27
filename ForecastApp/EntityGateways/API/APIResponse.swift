//
//  APIResponse.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 24/04/2023.
//

import Foundation

struct NetworkRequestError: Error {
    let error: Error?
    
    var localizedDescription: String {
        return error?.localizedDescription ?? "Network request error - no other information"
    }
}

struct APIError: Error {
    let data: Data?
    let httpUrlResponse: HTTPURLResponse
}

enum LocationError: Error {
    case locationPermissionDenied
}

struct APIParseError: Error {
    static let code = 999
    
    let error: Error
    let httpUrlResponse: HTTPURLResponse
    let data: Data?
    
    var localizedDescription: String {
        return error.localizedDescription
    }
}

struct APIResponse<T: Decodable> {
    let entity: T
    let httpURLResponse: HTTPURLResponse
    let data: Data?
    
    init(data: Data?, httpUrlResponse: HTTPURLResponse) throws {
        do {
            self.entity = try JSONDecoder().decode(T.self, from: data ?? Data())
            self.data = data
            self.httpURLResponse = httpUrlResponse
        } catch {
            throw APIParseError(error: error, httpUrlResponse: httpUrlResponse, data: data)
        }
    }
}

