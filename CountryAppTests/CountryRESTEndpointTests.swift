//
//  CountryRESTEndpointTests.swift
//  CountryAppTests
//
//  Created by Giovanni Romaniello on 01/01/22.
//

import XCTest

class CountryRESTEndpointTests: XCTestCase {

    func testEndpoints() throws {
        let allEndpoint = CountriesEndpoint.all
        var request = try! allEndpoint.asURLRequest()
        XCTAssertEqual(request.url?.absoluteString, "https://restcountries.com/v3.1/all")
        
        let continentEndpoint = CountriesEndpoint.byContinent(continent: "europe")
        request = try! continentEndpoint.asURLRequest()
        XCTAssertEqual(request.url?.absoluteString, "https://restcountries.com/v3.1/region/europe")
        
        let languageEndpoint = CountriesEndpoint.byLanguage(language: "ita")
        request = try! languageEndpoint.asURLRequest()
        XCTAssertEqual(request.url?.absoluteString, "https://restcountries.com/v3.1/lang/ita")
    }

}
