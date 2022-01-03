//
//  CountryListViewModelTests.swift
//  CountryAppTests
//
//  Created by Giovanni Romaniello on 03/01/22.
//

import XCTest

class CountryListViewModelTests: XCTestCase {
    
    private var viewModel: CountryListViewModel!
    private var repository = MockCountryRepository()

    override func setUpWithError() throws {
        viewModel = CountryListViewModel(with: repository)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testError() async throws {
        repository.forceError = true
        await viewModel.loadCountries()
        XCTAssertNotNil(viewModel.error)
    }

    func testLoadAllCountries() async throws {
        repository.forceError = false
        await viewModel.loadCountries()
        XCTAssertEqual(viewModel.countries.count, 250)
    }

}
