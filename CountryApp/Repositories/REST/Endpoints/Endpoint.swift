//
//  Endpoint.swift
//  CountryApp
//
//  Created by Giovanni Romaniello on 01/01/22.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    //not implementing all methods...
}

protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}

extension URLRequest: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest { self }
}

protocol Endpoint: URLRequestConvertible {
    var method: HTTPMethod { get }

    var parameters: Parameters? { get }

    var headers: HTTPHeaders? { get }

    var baseUrl: String { get }

    var accept: String { get }

    var path: String { get }

    var encoding: ParameterEncoding { get }
}

extension Endpoint {
    var baseUrl: String {
        "https://restcountries.com/v3.1"
    }

    var accept: String {
        "application/json"
    }
    
    var parameters: Parameters? {
        nil
    }
    
    var headers: HTTPHeaders? {
        nil
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let baseURL = URL(string: self.baseUrl) else {
            throw APIError.invalidUrl(statusCode: 0, url: self.baseUrl)
        }

        let url = baseURL.appendingPathComponent(path)

        var urlRequest = URLRequest(url: url)

        urlRequest.setValue(accept, forHTTPHeaderField: "Accept")
        urlRequest.setValue(accept, forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue

        headers?.forEach { (key, value) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        return try encoding.encode(urlRequest, with: self.parameters)
    }
    
    var encoding: ParameterEncoding {
        JSONEncoding.default
    }
}
