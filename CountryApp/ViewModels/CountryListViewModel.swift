//
//  CountryListViewModel.swift
//  CountryApp
//
//  Created by Giovanni Romaniello on 02/01/22.
//

import Foundation
import Combine

enum SortOrder {
    case byName
    case byRegion
}

class CountryListViewModel: ObservableObject {
    
    private let repository: CountryRepository
    
    var cancellables: Set<AnyCancellable> = []
    
    @Published var countries: [Country] = []
    private var allCountries: [Country] = []
    @Published var error: Error?
    @Published var searchText: String = ""
    @Published var isGrouped: Bool = false
    @Published var regions: [String: [Country]] = [:]
    @Published var showOptions: Bool = false
    @Published var sortOrder: SortOrder = .byName
    
    init(with repository: CountryRepository) {
        self.repository = repository
        $searchText
            .removeDuplicates()
            .map { (value) -> String? in
                guard value.count > 2 else {
                    return nil
                }
                return value
            }
            .sink { [weak self] value in
                guard let self = self else { return }
                if let value = value {
                    self.countries = self.allCountries.filter({ country in
                        country.languages?.values.contains(where: {
                            $0.range(of: value, options: .caseInsensitive) != nil
                        }) == true ||
                        country.languages?.keys.contains(where: {
                            $0.range(of: value, options: .caseInsensitive) != nil
                        }) == true ||
                        country.region?.lowercased().contains(value.lowercased()) == true
                    })
                } else {
                    self.countries = self.allCountries
                }
            }
            .store(in: &cancellables)
        $countries
            .sink(receiveValue: { [weak self] newCountries in
                guard let self = self else { return }
                self.regions.removeAll()
                newCountries.forEach { country in
                    if self.regions[country.region ?? ""] == nil {
                        self.regions[country.region ?? ""] = [country]
                    } else {
                        self.regions[country.region ?? ""]?.append(country)
                    }
                }
            })
            .store(in: &cancellables)
        $sortOrder
            .removeDuplicates()
            .sink(receiveValue: { [weak self] sort in
                guard let self = self else { return }
                self.sort(order: sort)
            })
            .store(in: &cancellables)
    }
    
    private func sort(order: SortOrder) {
        switch order {
        case .byName:
            countries = countries.sorted(by: { lhs, rhs in
                lhs.name.common < rhs.name.common
            })
        case .byRegion:
            countries = countries.sorted(by: { lhs, rhs in
                lhs.region ?? "" < rhs.region ?? ""
            })
        }
    }
    
    func loadCountries() async {
        do {
            error = nil
            allCountries = try await self.repository.retrieveAllCountries()
            countries = allCountries
            sort(order: sortOrder)
        } catch {
            print(error.localizedDescription)
            allCountries = []
            regions = [:]
            countries = []
            let userError = UserError.error(message: "error.generic".localized)
            self.error = userError
        }
    }
}
