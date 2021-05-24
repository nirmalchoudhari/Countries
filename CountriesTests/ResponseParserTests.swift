//
//  ResponseParserTests.swift
//  CountriesTests
//
//  Created by Nirmal Choudhari on 24/05/21.
//

import XCTest
@testable import Countries

class CustomTestCase<T>: XCTestCase {}

class ResponseParserTests: CustomTestCase<Country> {
    
    var sut: ResponseParser<[Country]>!
    
    override func setUpWithError() throws {
        sut = ResponseParser<[Country]>()
        
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testParseValidResposneNoError() {
        // Given
        let apiResposne = MockAPIResponse.validResponseNoError()
        // When
        let response = sut.handleResposne(apiResposne)
        
        // Then
        XCTAssertNotNil(response, "Response should not be nil")
        switch response {
        case .result(let countries):
            XCTAssertFalse(countries.isEmpty, "Response should not be empty")
        case .error(let error):
            XCTAssertNil(error, "There should be no error")
        }
    }

    func testParseInValidResposneAPIError() {
        // Given
        let apiResposne = MockAPIResponse.invalidResposneAPIError()
        // When
        let response = sut.handleResposne(apiResposne)

        // Then
        XCTAssertNotNil(response, "Response should not be nil")
        switch response {
        case .result(let countries):
            XCTAssertNil(countries, "Countries should not be nil")
        case .error(let error):
            XCTAssertNotNil(error, "There should be an error")
            XCTAssertTrue(error == APIError.fetchFailed(MockError.networkFail), "Network Fail error should occour")
        }
    }

    func testParseInValidResposneSerelizationError() {
        // Given
        let apiResposne = MockAPIResponse.invalidResponseSerelizationError()
        // When
        let response = sut.handleResposne(apiResposne)
        
        // Then
        XCTAssertNotNil(response, "Response should not be nil")
        switch response {
        case .result(let countries):
            XCTAssertNil(countries, "Countries should not be nil")
        case .error(let error):
            XCTAssertNotNil(error, "There should be an error")
            XCTAssertTrue(error == APIError.serelization, "Serialization error should occour")
        }
    }
    
    func testParseInValidResposneNoData() {
        // Given
        let apiResposne = MockAPIResponse.invalidResposneNoData()
        // When
        let response = sut.handleResposne(apiResposne)
        
        // Then
        XCTAssertNotNil(response, "Response should not be nil")
        switch response {
        case .result(let countries):
            XCTAssertNil(countries, "Countries should not be nil")
        case .error(let error):
            XCTAssertNotNil(error, "There should be an error")
            XCTAssertTrue(error == APIError.noData, "Nodata error should occour")
        }
    }


    
}
