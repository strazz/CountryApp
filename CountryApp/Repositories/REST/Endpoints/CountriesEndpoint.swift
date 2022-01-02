//
//  CountriesEndpoint.swift
//  CountryApp
//
//  Created by Giovanni Romaniello on 01/01/22.
//

import Foundation

enum CountriesEndpoint {
    case all
    case byContinent(continent: String)
    case byLanguage(language: String)
}

extension CountriesEndpoint: Endpoint {
    var method: HTTPMethod {
        .GET
    }
    
    var path: String {
        switch self {
        case .all:
            return "/all"
        case .byContinent(let continent):
            return "/region/\(continent)"
        case .byLanguage(let language):
            return "lang/\(language)"
        }
    }
    
    
}
