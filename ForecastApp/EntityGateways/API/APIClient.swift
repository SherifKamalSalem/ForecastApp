//
//  APIClient.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 24/04/2023.
//

import Foundation

protocol APIRequest {
    var urlRequest: URLRequest { get }
}

protocol APIClient {
    func execute<T>(request: APIRequest) async throws -> Result<APIResponse<T>>
}

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
