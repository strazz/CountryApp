//
//  CountryViewFactory.swift
//  CountryApp
//
//  Created by Giovanni Romaniello on 02/01/22.
//

import Foundation

class CountryViewFactory {
    
    static func buildCountryListView(repository: CountryRepository) -> CountryListView {
        let viewModel = CountryListViewModel(with: repository)
        return CountryListView(with: viewModel)
    }
    
    static func buildCountryRowView(country: Country) -> CountryRowView {
        let viewModel = CountryRowViewModel(with: country)
        return CountryRowView(with: viewModel)
    }
}
