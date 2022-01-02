//
//  CountryListViewModel.swift
//  CountryApp
//
//  Created by Giovanni Romaniello on 02/01/22.
//

import Foundation
import Combine

class CountryListViewModel: ObservableObject {
    private let repository: CountryRepository
    
    @Published var countries: [Country] = []
    
    init(with repository: CountryRepository) {
        self.repository = repository
    }
    
    func loadCountries() async {
        do {
            countries = try await self.repository.retrieveAllCountries()
        } catch {
            print(error)
            print(error.localizedDescription)
            //TODO error handling
        }
    }
}
