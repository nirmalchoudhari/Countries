//
//  MockAPIResponse.swift
//  CountriesTests
//
//  Created by Nirmal Choudhari on 24/05/21.
//

import Foundation
@testable import Countries

enum MockError: Error, Equatable {
    case networkFail
    static func == (lhs: MockError, rhs: MockError) -> Bool {
        switch (lhs, rhs) {
        case (.networkFail, .networkFail): return true
        }
    }
}

class MockAPIResponse {
    
    static func validProvenanceResponseNoError() -> APIResponse {
        let jsonString = #"[{"ID":97,"CountryCode":"US","Code":"AL","Name":"Alabama"},{"ID":101,"CountryCode":"US","Code":"AK","Name":"Alaska"},{"ID":132,"CountryCode":"US","Code":"AS","Name":"American Samoa"}]"#
        let data = Data(jsonString.utf8)
        return APIResponse(data: data, error: nil)
    }
    
    static func validResponseNoError() -> APIResponse {
        let jsonString = #"[{"ID":227,"Name":"UNITED STATES","Code":"US","PhoneCode":"1"},{"ID":4,"Name":"AFGHANISTAN","Code":"AF","PhoneCode":"93"}]"#
        let data = Data(jsonString.utf8)
        return APIResponse(data: data, error: nil)
    }
    
    static func invalidResponseSerelizationError() -> APIResponse  {
        let jsonString = #"[{"ID":97,"CountryCode":"US","Code":"AL","Name":"Alabama"},{"ID":101,"CountryCode":"US","Code":"AK","Name":"Alaska"},{"ID":132,"CountryCode":"US","Code":"AS","Name":"American Samoa]"#
        let data = Data(jsonString.utf8)
        return APIResponse(data: data, error: nil)
    }
    
    static func invalidResposneAPIError () -> APIResponse  {
        return APIResponse(data: nil, error: MockError.networkFail)
    }
    
    static func invalidResposneNoData () -> APIResponse  {
        return APIResponse(data: nil, error: nil)
    }
}
