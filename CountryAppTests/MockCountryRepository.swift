//
//  MockCountryRepository.swift
//  CountryAppTests
//
//  Created by Giovanni Romaniello on 30/12/21.
//

import Foundation

class MockCountryRepository {
    private let decoder = JSONDecoder()
    private lazy var countries: [Country] = {
        guard let url = Bundle(for: type(of: self)).url(forResource: "countries", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let json = try? decoder.decode([Country].self, from: data) else {
            return []
        }
        return json
    }()
}

extension MockCountryRepository: CountryRepository {
    func retrieveAllCountries() async -> [Country] {
        countries
    }
    
    func retrieveCountryByContinent(continent: String) async -> [Country] {
        countries.filter { country in
            country.continents?.contains(where: { aContinent in
                aContinent.lowercased() == continent.lowercased()
            }) == true
        }
    }
    
    func retrieveCountryByLanguage(language: String) async -> [Country] {
        countries.filter { country in
            country.languages?.contains(where: { aLanguage in
                aLanguage.value.lowercased() == language.lowercased() ||
                aLanguage.value.lowercased().starts(with: language.lowercased()) ||
                aLanguage.key.lowercased() == language.lowercased()
            }) == true
        }
    }
    
    
}
