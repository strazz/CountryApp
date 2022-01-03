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
    @Published var error: Error?
    
    init(with repository: CountryRepository) {
        self.repository = repository
    }
    
    func loadCountries() async {
        do {
            countries = try await self.repository.retrieveAllCountries()
        } catch {
            //prints the "real" error
            print(error.localizedDescription)
            countries = []
            let userError = UserError.error(message: "error.generic".localized)
            self.error = userError
        }
    }
}
