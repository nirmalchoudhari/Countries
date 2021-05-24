//
//  ProvenanceViewModelTests.swift
//  CountriesTests
//
//  Created by Nirmal Choudhari on 24/05/21.
//

import XCTest
@testable import Countries

class ProvenanceViewModelTests: XCTestCase {

    var sut: ProvenanceViewModel!
    
    override func setUpWithError() throws {
        sut = ProvenanceViewModel(networkService: MockNetworkService())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testCountriesVMMethods() {
        //Given mock data is used by URLService Mock from MockAPIResposne
        
        // Test no provenance
        
        XCTAssertTrue(sut.noProvenance, "Initially no provenance avaialble")
        
        // Test fetch countries
        let expctation = self.expectation(description: "test fetch countries")
        var provenances:[Provenance]?
        sut.fetchProvenances(for: 1){ (provenanceList, error) in
            provenances = provenanceList
            expctation.fulfill()
        }
        
        wait(for: [expctation], timeout: 5)
        XCTAssertNotNil(provenances, "api should return data")
        // test number of rows
        XCTAssertTrue(sut.numberOfRows() != 0, "must have countries")
        XCTAssertTrue(sut.numberOfRows() == 3, "must have three countries")
        
        guard let provenance = sut.getProvenance(0) else {
            XCTFail("Should return a provenance")
            return
        }
        //{"ID":97,"CountryCode":"US","Code":"AL","Name":"Alabama"}
        XCTAssertEqual(provenance.id, 97 , "id should match")
        XCTAssertEqual(provenance.name, "Alabama" , "name should match")
        XCTAssertEqual(provenance.code, "AL" , "code should match")
        XCTAssertEqual(provenance.countryCode, "US" , "countryCode should match")
        
        
        
    }
}
