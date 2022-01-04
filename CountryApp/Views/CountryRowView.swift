//
//  CountryRowView.swift
//  CountryApp
//
//  Created by Giovanni Romaniello on 02/01/22.
//

import SwiftUI

struct CountryRowView: View {
    @ObservedObject var viewModel: CountryRowViewModel
    
    init(with viewModel: CountryRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 8, content: {
            NetworkImageView(url: URL(string: viewModel.flag ?? ""))
                .frame(width: 50, height: 50, alignment: .center)
                .background(Color.clear)
            VStack(alignment: .leading,
                   spacing: 8,
                   content: {
                if let name = viewModel.name {
                    Text(name).bold()
                }
                if let region = viewModel.region {
                    HStack(alignment: .top, spacing: 8) {
                        Text("label.region".localized).bold()
                        HighlightedText(region, matching: viewModel.searchText ?? "")
                    }
                }
                if let languages = viewModel.languages {
                    HStack(alignment: .top, spacing: 8) {
                        Text("label.languages".localized).bold()
                        HighlightedText(languages, matching: viewModel.searchText ?? "")
                    }
                }
            })
        })
        .padding(8)
    }
}

struct CountryRowView_Previews: PreviewProvider {
    static var previews: some View {
        let mockCountry = Country(
            name: CountryName(common: "Italia", official: "Italia"),
            independent: nil,
            status: nil,
            capital: nil,
            currencies: nil,
            region: "europe",
            subregion: nil,
            languages: ["ita": "Italian"],
            area: nil,
            population: nil,
            latlng: nil,
            flag: nil,
            maps: nil,
            continents: nil,
            flags: ["png": "https://flagcdn.com/w320/it.png"],
            coatOfArms: nil)
        let viewModel = CountryRowViewModel(with: mockCountry)
        CountryRowView(with: viewModel)
    }
}
