//
//  UserError.swift
//  CountryApp
//
//  Created by Giovanni Romaniello on 03/01/22.
//

import Foundation

enum UserError: LocalizedError {
    case error(message: String)
    
    var errorDescription: String? {
        switch self {
        case .error(let message):
            return message
        }
    }
}
