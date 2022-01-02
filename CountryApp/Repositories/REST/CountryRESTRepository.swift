//
//  CountryRESTRepository.swift
//  CountryApp
//
//  Created by Giovanni Romaniello on 01/01/22.
//

import Foundation

@MainActor
class CountryRESTRepository {
    private let apiClient = APIClient()
}

extension CountryRESTRepository: CountryRepository {
    func retrieveAllCountries() async throws -> [Country] {
        let request = CountriesEndpoint.all
        let response: APIClient.Response<[Country]> = try await apiClient.run(request.asURLRequest())
        return response.value
    }
    
    func retrieveCountryByContinent(continent: String) async throws -> [Country] {
        let request = CountriesEndpoint.byContinent(continent: continent)
        let response: APIClient.Response<[Country]> = try await apiClient.run(request.asURLRequest())
        return response.value
    }
    
    func retrieveCountryByLanguage(language: String) async throws -> [Country] {
        let request = CountriesEndpoint.byLanguage(language: language)
        let response: APIClient.Response<[Country]> = try await apiClient.run(request.asURLRequest())
        return response.value
    }
    
    
}
