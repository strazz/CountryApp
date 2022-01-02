//
//  APIError.swift
//  CountryApp
//
//  Created by Giovanni Romaniello on 01/01/22.
//

import Foundation

enum APIError: LocalizedError {

    case invalidUrl(statusCode: Int, url: String)
    case serializationError(statusCode: Int, reason: String)
    case applicationError(errorCode: Int, statusCode: Int, message: String)

    public var errorDescription: String? {
        switch self {
        case .serializationError(_, let reason):
            return "Parsing error: \(reason)"
        case .invalidUrl(_, let url):
            return "URL is not valid: \(url)"
        case .applicationError(_, _, let message):
            return message
        }
    }

    public var errorCode: Int? {
        switch self {
        case .applicationError(let errorCode, _, _):
            return errorCode
        default:
            return nil
        }
    }

    public var statusCode: Int? {
        switch self {
        case .serializationError(let statusCode, _):
            return statusCode
        case .invalidUrl(let statusCode, _):
            return statusCode
        case .applicationError(_, let statusCode, _):
            return statusCode
        }
    }
}
