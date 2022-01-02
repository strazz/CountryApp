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
            List {
                ForEach(viewModel.countries, id: \.id) { country in
                    CountryViewFactory.buildCountryRowView(country: country)
                }
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
        .navigationTitle("CountryApp")
        .navigationBarTitleDisplayMode(.automatic)
    }
}

struct CountryListView_Previews: PreviewProvider {
    static var previews: some View {
        CountryViewFactory.buildCountryListView(repository: MockCountryRepository())
    }
}
