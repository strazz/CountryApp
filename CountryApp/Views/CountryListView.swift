//
//  ContentView.swift
//  CountryApp
//
//  Created by Giovanni Romaniello on 30/12/21.
//

import SwiftUI

struct CountryListView: View {
    
    @ObservedObject private var viewModel: CountryListViewModel
    
    init(with viewModel: CountryListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.countries) { country in
                CountryViewFactory.buildCountryRowView(country: country)
            }
            .navigationBarTitle("CountryApp", displayMode: .inline)
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarHidden(false)
        }
        .overlay(alignment: .center) {
            if let error = viewModel.error {
                ErrorView(with: error)
            }
        }
        .onAppear(perform: {
            Task {
                await viewModel.loadCountries()
            }
        })
        .refreshable {
            await viewModel.loadCountries()
        }
    }
}

struct CountryListView_Previews: PreviewProvider {
    static var previews: some View {
        CountryViewFactory.buildCountryListView(repository: MockCountryRepository())
    }
}
