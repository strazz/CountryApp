//
//  CountryRepository.swift
//  CountryApp
//
//  Created by Giovanni Romaniello on 30/12/21.
//

import Foundation

protocol CountryRepository {
    
    func retrieveAllCountries() async throws -> [Country]
    func retrieveCountryByContinent(continent: String) async throws -> [Country]
    func retrieveCountryByLanguage(language: String) async throws -> [Country]
}
