//
//  CountryRowViewModel.swift
//  CountryApp
//
//  Created by Giovanni Romaniello on 02/01/22.
//

import Foundation

class CountryRowViewModel: ObservableObject {
    
    @Published var flag: String?
    @Published var name: String?
    @Published var imageData: Data?
    
    init(with country: Country) {
        flag = country.flags?["png"]
        name = country.name.common
    }
}
