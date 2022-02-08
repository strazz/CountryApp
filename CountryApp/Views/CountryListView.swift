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
            VStack {
                HStack(alignment: .top, spacing: 8) {
                    TextField("search.placeholder".localized, text: $viewModel.searchText)
                        .padding(8)
                        .background(Color.lightGray)
                        .clipped()
                        .cornerRadius(8)
                }
                .padding(SwiftUI.Edge.Set.horizontal, 8)
                VStack(alignment: .leading) {
                    Toggle("label.group".localized, isOn: $viewModel.isGrouped)
                    Button("button.sort".localized) {
                        viewModel.showOptions = true
                    }
                    .clipShape(Capsule())  
                }
                .padding(8)
                if viewModel.countries.isEmpty, viewModel.error == nil {
                    ProgressView()
                    Spacer()
                } else {
                    if viewModel.isGrouped {
                        List {
                            ForEach(Array(viewModel.regions.keys).sorted(by: <), id: \.self) {
                                key in
                                Section(key) {
                                    let countries = viewModel.regions[key]
                                    ForEach(countries ?? []) {
                                        country in
                                        CountryViewFactory.buildCountryRowView(country: country, searchText: viewModel.searchText)
                                    }
                                }
                            }
                            
                        }
                    } else {
                        List(viewModel.countries) { country in
                            
                            CountryViewFactory.buildCountryRowView(country: country, searchText: viewModel.searchText)
                        }
                    }
                    
                    
                }
            }
            .navigationBarTitle("CountryApp", displayMode: .inline)
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarHidden(false)
            .actionSheet(isPresented: $viewModel.showOptions) {
                        ActionSheet(
                            title: Text("button.sort".localized),
                            buttons: [
                                .cancel { },
                                .default(Text("label.sort.name".localized)) {
                                    viewModel.sortOrder = .byName
                                },
                                .default(Text("label.sort.region".localized)) {
                                    viewModel.sortOrder = .byRegion
                                }
                            ]
                        )
                    }
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
