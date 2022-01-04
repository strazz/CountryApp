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
    
    static func buildCountryRowView(country: Country, searchText: String?) -> CountryRowView {
        let viewModel = CountryRowViewModel(with: country)
        viewModel.searchText = searchText
        return CountryRowView(with: viewModel)
    }
}
