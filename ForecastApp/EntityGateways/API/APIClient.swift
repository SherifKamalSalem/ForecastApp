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

class ApiClientImplementation: APIClient {
    private let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
    
    init(urlSessionConfiguration: URLSessionConfiguration, completionHandlerQueue: OperationQueue) {
        self.urlSession = URLSession(configuration: urlSessionConfiguration, delegate: nil, delegateQueue: completionHandlerQueue)
    }
    
    func execute<T>(request: APIRequest) async throws -> Result<APIResponse<T>> {
        let (data, response) = try await urlSession.data(for: request.urlRequest)
        guard let httpUrlResponse = response as? HTTPURLResponse else {
            return .failure(NetworkRequestError(error: NSError(domain: "", code: 0)))
        }
        let successRange = 200...299
        if successRange.contains(httpUrlResponse.statusCode) {
            do {
                let response = try APIResponse<T>(data: data, httpUrlResponse: httpUrlResponse)
                return .success(response)
            } catch {
                return .failure(error)
            }
        } else {
            return .failure(APIError(data: data, httpUrlResponse: httpUrlResponse))
        }
    }
}

