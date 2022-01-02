//
//  Country.swift
//  CountryApp
//
//  Created by Giovanni Romaniello on 30/12/21.
//

import Foundation

struct Country: Codable {
    let name: CountryName
    let independent: Bool?
    let status: String?
    let capital: [String]?
    let currencies: [String: CountryCurrency]?
    let region: String?
    let subregion: String?
    let languages: [String: String]?
    let area: Double?
    let population: Int?
    let latlng: [Double]?
    let flag: String?
    let maps: [String: String]?
    let continents: [String]?
    let flags: [String: String]?
    let coatOfArms: [String: String]?
}

struct CountryName: Codable {
    let common: String
    let official: String
}

struct CountryCurrency: Codable {
    let name: String
    let symbol: String?
}

extension Country: Identifiable {
    var id: UUID {
        UUID()
    }
}
