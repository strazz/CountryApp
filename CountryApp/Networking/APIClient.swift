//
//  APIClient.swift
//  CountryApp
//
//  Created by Giovanni Romaniello on 01/01/22.
//

import Foundation

struct APIClient {
    
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    func run<T: Decodable>(_ request: URLRequest) async throws -> Response<T> {
        let (data, response) = try await URLSession.shared.data(for: request)
        let value = try JSONDecoder().decode(T.self, from: data)
        return Response(value: value, response: response)
    }
    
    func run(_ request: URLRequest) async throws -> Response<Data> {
        let (data, response) = try await URLSession.shared.data(for: request)
        return Response(value: data, response: response)
    }
}
