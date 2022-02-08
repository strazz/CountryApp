//
//  CountryDetailViewModel.swift
//  CountryApp
//
//  Created by Giovanni Romaniello on 04/01/22.
//

import Foundation
import MapKit

class CountryDetailViewModel: ObservableObject {
    
    @Published var flagImageUrl: String?
    @Published var name: String?
    @Published var languages: String?
    @Published var showLanguages = true
    @Published var region: String?
    @Published var showRegion = true
    @Published var capital: String?
    @Published var showCapital = true
    @Published var coatImageUrl: String?
    @Published var showCoat = true
    @Published var mapRegion: MKCoordinateRegion!
    @Published var showMap = false
    var isMapAvailable = false
    
    init(with country: Country) {
        flagImageUrl = country.flags?["png"]
        name = country.name.common
        if let values = country.languages?.values {
            languages = Array(values).joined(separator: ", ")
        }
        if let regionValue = country.region {
            region = regionValue
        }
        if let capitals = country.capital {
            capital = Array(capitals).joined(separator: ", ")
        }
        coatImageUrl = country.coatOfArms?["png"]
        if let coordinates = country.latlng, coordinates.count > 1 {
            isMapAvailable = true
            showMap = true
            mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coordinates[0], longitude: coordinates[1]),
                                           span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
        }
    }
    
    func resetState() {
        showLanguages = true
        showRegion = true
        showCapital = true
        showCoat = true
        showMap = isMapAvailable
    }
}
