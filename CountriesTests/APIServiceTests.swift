//
//  APIServiceTests.swift
//  CountriesTests
//
//  Created by Nirmal Choudhari on 24/05/21.
//

import XCTest
@testable import Countries

class APIServiceTests: XCTestCase {
    
    var sut: APIService!

    override func setUpWithError() throws {
        sut = APIService(with: MockNetworkService())
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testFetchCountries() {
        let expectation = self.expectation(description: "load countries")
        var countries: [Country]?
        sut.fetchCountries { response in
            switch response {
            case .result(let countryList): countries = countryList
            default: break
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
        XCTAssertNotNil(countries, "api should return countries")
    }
    
    func testFetchProvenance() {
        let expectation = self.expectation(description: "load provenance")
        var provenance: [Provenance]?
        sut.fetchProvenance(for: 10) { response in
            switch response {
            case .result(let provenanceList): provenance = provenanceList
            default: break
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
        XCTAssertNotNil(provenance, "api should return provenance")
    }
}
