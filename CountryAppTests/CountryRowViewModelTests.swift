//
//  CountryRowViewModelTests.swift
//  CountryAppTests
//
//  Created by Giovanni Romaniello on 03/01/22.
//

import XCTest

class CountryRowViewModelTests: XCTestCase {
    
    private var viewModel: CountryRowViewModel!
    private let country = Country(
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
    
    override func setUpWithError() throws {
        viewModel = CountryRowViewModel(with: country)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testName() {
        XCTAssertEqual("Italia", viewModel.name)
    }
    
    func testFlag() {
        XCTAssertEqual("https://flagcdn.com/w320/it.png", viewModel.flag)
    }
    
    func testLanguages() {
        XCTAssertEqual("Italian", viewModel.languages)
    }
    
    func testRegion() {
        XCTAssertEqual("europe", viewModel.region)
    }
}
