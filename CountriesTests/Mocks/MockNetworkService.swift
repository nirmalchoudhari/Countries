//
//  MockNetworkService.swift
//  CountriesTests
//
//  Created by Nirmal Choudhari on 24/05/21.
//

import Foundation
@testable import Countries

class MockNetworkService: NetworkService {
    func execute(_ requestType: RequestType, responseQueue: DispatchQueue, completion: @escaping (APIResponse) -> Void) {
        responseQueue.async {
            switch requestType {
            case .counties: completion(MockAPIResponse.validResponseNoError())
            case .provenance(_): completion(MockAPIResponse.validProvenanceResponseNoError())
            }
            
        }
    }
    
    func execute(_ requestType: RequestType, completion: @escaping (APIResponse) -> Void) {
        execute(requestType, responseQueue: .main, completion: completion)
    }
    
    
}
