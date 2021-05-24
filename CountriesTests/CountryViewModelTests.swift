//
//  CountryViewModelTests.swift
//  CountriesTests
//
//  Created by Nirmal Choudhari on 24/05/21.
//

import XCTest
@testable import Countries

class CountryViewModelTests: XCTestCase {

    var sut: CountryViewModel!
    
    override func setUpWithError() throws {
        sut = CountryViewModel(networkService: MockNetworkService())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testCountriesVMMethods() {
        //Given mock data is used by URLService Mock from MockAPIResposne
        
        // Test fetch countries
        let expctation = self.expectation(description: "test fetch countries")
        var countries:[Country]?
        sut.fetchCountries { (countryList, error) in
            countries = countryList
            expctation.fulfill()
        }
        
        wait(for: [expctation], timeout: 5)
        XCTAssertNotNil(countries, "api should return data")
        // test number of rows
        XCTAssertTrue(sut.numberOfRows(.complete) != 0, "must have countries")
        XCTAssertTrue(sut.numberOfRows(.complete) == 2, "must have three countries")
        
        guard let country = sut.getCountry(0, mode: .complete) else {
            XCTFail("Should return a country")
            return
        }
        //{"ID":227,"Name":"UNITED STATES","Code":"US","PhoneCode":"1"}
        XCTAssertEqual(country.id, 227 , "id should match")
        XCTAssertEqual(country.name, "UNITED STATES" , "name should match")
        XCTAssertEqual(country.code, "US" , "code should match")
        XCTAssertEqual(country.phoneCode, "1" , "phoneCode should match")
        
        sut.filterCountries("UN")
        XCTAssertTrue(sut.numberOfRows(.filtered) != 0, "must have countries")
        XCTAssertTrue(sut.numberOfRows(.filtered) == 1, "must have 1 country")
        
        guard let filetredCountry = sut.getCountry(0, mode: .filtered) else {
            XCTFail("Should return a country")
            return
        }
        //{"ID":227,"Name":"UNITED STATES","Code":"US","PhoneCode":"1"}
        XCTAssertEqual(filetredCountry.id, 227 , "id should match")
        XCTAssertEqual(filetredCountry.name, "UNITED STATES" , "name should match")
        XCTAssertEqual(filetredCountry.code, "US" , "code should match")
        XCTAssertEqual(filetredCountry.phoneCode, "1" , "phoneCode should match")
        
    }
}
