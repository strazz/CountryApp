//
//  ParameterEncoding.swift
//  CountryApp
//
//  Created by Giovanni Romaniello on 01/01/22.
//

import Foundation

typealias Parameters = [String: Any]
typealias HTTPHeaders = [String: String]


protocol ParameterEncoding {
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest
}

struct JSONEncoding: ParameterEncoding {
    // MARK: Properties

    /// Returns a `JSONEncoding` instance with default writing options.
    public static var `default`: JSONEncoding { JSONEncoding() }

    /// Returns a `JSONEncoding` instance with `.prettyPrinted` writing options.
    public static var prettyPrinted: JSONEncoding { JSONEncoding(options: .prettyPrinted) }

    /// The options for writing the parameters as JSON data.
    public let options: JSONSerialization.WritingOptions

    // MARK: Initialization

    /// Creates an instance using the specified `WritingOptions`.
    ///
    /// - Parameter options: `JSONSerialization.WritingOptions` to use.
    public init(options: JSONSerialization.WritingOptions = []) {
        self.options = options
    }

    // MARK: Encoding

    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()

        guard let parameters = parameters else { return urlRequest }

        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: options)
            
            if urlRequest.allHTTPHeaderFields?["Content-Type"] == nil {
                urlRequest.allHTTPHeaderFields?.updateValue("application/json", forKey: "Content-Type")
            }

            urlRequest.httpBody = data
        } catch {
            throw APIError.serializationError(statusCode: -1, reason: error.localizedDescription)
        }

        return urlRequest
    }
}
