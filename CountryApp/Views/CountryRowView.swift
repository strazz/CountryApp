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
        HStack {
            AsyncImage(url: URL(string: viewModel.flag ?? "")) {
                phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else {
                    ProgressView()
                }
            }
            .frame(width: 50, height: 50, alignment: .center)
            .background(Color.clear)
            Text(viewModel.name ?? "")
        }
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
            region: nil,
            subregion: nil,
            languages: nil,
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
