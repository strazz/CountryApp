//
//  CountryRowViewModel.swift
//  CountryApp
//
//  Created by Giovanni Romaniello on 02/01/22.
//

import Foundation

class CountryRowViewModel: ObservableObject {
    
    @Published var flag: String?
    @Published var name: String?
    @Published var languages: String?
    @Published var region: String?
    
    init(with country: Country) {
        flag = country.flags?["png"]
        name = country.name.common
        if let values = country.languages?.values {
            languages = "\("label.languages".localized) \(Array(values).joined(separator: ", "))"
        }
        if let regionValue = country.region {
            region = "\("label.region".localized) \(regionValue)"
        }
    }
}
