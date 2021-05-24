//
//  URLSessionServiceTests.swift
//  CountriesTests
//
//  Created by Nirmal Choudhari on 24/05/21.
//

import XCTest
@testable import Countries

class URLSessionServiceTests: XCTestCase {
    
    var sut: URLSessionService!

    override func setUpWithError() throws {
        let reposne: SessionResposne = (data: MockAPIResponse.validResponseNoError().data, res:nil, err:nil)
        let session = MockURLSession() // Kept this deprecation as not breaking anything
        session.resposne = reposne
        sut = URLSessionService(session: session)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testExecuteAPI() {
        let expectation = self.expectation(description: "Testing URL Session")
        var responseData: Data?
        sut.execute(.counties) { (response) in
            responseData = response.data
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 4)
        XCTAssertNotNil(responseData, "api should return data")
    }
    
}
