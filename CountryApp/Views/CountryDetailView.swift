//
//  CountryDetailView.swift
//  CountryApp
//
//  Created by Giovanni Romaniello on 04/01/22.
//

import SwiftUI
import MapKit

struct CountryDetailView: View {
    
    @ObservedObject var viewModel: CountryDetailViewModel
    
    init(with viewModel: CountryDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                if let name = viewModel.name {
                    Text(name).bold()
                }
                if let flag = viewModel.flagImageUrl {
                    NetworkImageView(url: URL(string: flag))
                        .frame(width: 100, height: 100, alignment: .center)
                        .background(Color.clear)
                }
                if let coat = viewModel.coatImageUrl {
                    Group {
                        HStack {
                            Text("label.coat".localized).bold()
                            Spacer()
                            ToggleViewButton(show: viewModel.showCoat) {
                                viewModel.showCoat.toggle()
                            }
                        }
                        if viewModel.showCoat {
                            NetworkImageView(url: URL(string: coat))
                                .frame(width: 100, height: 100, alignment: .center)
                                .background(Color.clear)
                        }
                    }
                }
                if let region = viewModel.region {
                    HStack(alignment: .top, spacing: 8) {
                        Text("label.region".localized).bold()
                        Spacer()
                        ToggleViewButton(show: viewModel.showRegion) {
                            viewModel.showRegion.toggle()
                        }
                    }
                    if viewModel.showRegion {
                        Text(region)
                    }
                }
                if let languages = viewModel.languages {
                    HStack(alignment: .top, spacing: 8) {
                        Text("label.languages".localized).bold()
                        Spacer()
                        ToggleViewButton(show: viewModel.showLanguages) {
                            viewModel.showLanguages.toggle()
                        }
                    }
                    if viewModel.showLanguages {
                        Text(languages)
                    }
                }
                if let capital = viewModel.capital {
                    HStack(alignment: .top, spacing: 8) {
                        Text("label.capital".localized).bold()
                        Spacer()
                        ToggleViewButton(show: viewModel.showCapital) {
                            viewModel.showCapital.toggle()
                        }
                    }
                    if viewModel.showCapital {
                        Text(capital)
                    }
                }
                if viewModel.isMapAvailable {
                    HStack {
                        Text("label.map".localized).bold()
                        Spacer()
                        ToggleViewButton(show: viewModel.showMap) {
                            viewModel.showMap.toggle()
                        }
                    }
                    if viewModel.showMap {
                        Map(coordinateRegion: $viewModel.mapRegion)
                            .frame(width: 300, height: 300)
                    }
                }
            }
            .padding(SwiftUI.Edge.Set.horizontal, 8)
        }
        .padding(SwiftUI.Edge.Set.horizontal, 8)
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .topLeading
            )
    }
}

struct CountryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let mockCountry = Country(
            name: CountryName(common: "Italia", official: "Italia"),
            independent: nil,
            status: nil,
            capital: [
                "Rome"
            ],
            currencies: nil,
            region: "europe",
            subregion: nil,
            languages: ["ita": "Italian"],
            area: nil,
            population: nil,
            latlng: [
                42.83333333,
                12.83333333
            ],
            flag: nil,
            maps: nil,
            continents: nil,
            flags: ["png": "https://flagcdn.com/w320/it.png"],
            coatOfArms: ["png": "https://mainfacts.com/media/images/coats_of_arms/it.png"])
        let viewModel = CountryDetailViewModel(with: mockCountry)
        CountryDetailView(with: viewModel)
    }
}
