//
//  CountryViewFactory.swift
//  CountryApp
//
//  Created by Giovanni Romaniello on 02/01/22.
//

import Foundation
import SwiftUI

class CountryViewFactory {
    
    static func buildCountryListView(repository: CountryRepository) -> some View {
        let viewModel = CountryListViewModel(with: repository)
        return CountryListView(with: viewModel)
    }
    
    static func buildCountryRowView(country: Country, searchText: String?) -> some View {
        let viewModel = CountryRowViewModel(with: country)
        viewModel.searchText = searchText
        return NavigationLink(destination: buildCountryDetailView(country: country)) {
            CountryRowView(with: viewModel)
        }
    }
    
    static func buildCountryDetailView(country: Country) -> some View {
        let viewModel = CountryDetailViewModel(with: country)
        return CountryDetailView(with: viewModel)
    }
}
