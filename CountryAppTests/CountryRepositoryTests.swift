//
//  CountryAppTests.swift
//  CountryAppTests
//
//  Created by Giovanni Romaniello on 30/12/21.
//

import XCTest
@testable import CountryApp

class CountryRepositoryTests: XCTestCase {
    
    private var repository: CountryRepository!

    override func setUpWithError() throws {
        repository = MockCountryRepository()
    }
    
    override func tearDown() {
        repository = nil
    }

    func testRetrieveAllCountries() async throws {
        let result = try await repository.retrieveAllCountries()
        XCTAssertEqual(result.count, 250)
    }

    func testRetrieveCountriesByContinent() async throws {
        let result = try await repository.retrieveCountryByContinent(continent: "europe")
        XCTAssertEqual(result.count, 53)
    }
    
    func testRetrieveCountriesByLanguage() async throws {
        let result = try await repository.retrieveCountryByLanguage(language: "ita")
        XCTAssertEqual(result.count, 4)
    }
}
