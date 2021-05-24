//
//  APIService.swift
//  Countries
//
//  Created by Nirmal Choudhari on 22/05/21.
//

import Foundation

/// Enum representing API Errors
enum APIError: LocalizedError, Equatable {
    case noData
    case serelization
    case fetchFailed(Error)
    
    public var errorDescription: String? {
        switch self {
        case .noData:
            return Constants.noDataAvaialble
        case .serelization:
            return Constants.serilizationError
        case .fetchFailed(let error):
            return error.localizedDescription
        }
    }
    
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.noData, .noData): return true
        case (.serelization, .serelization): return true
        case (.fetchFailed(let lhsError), .fetchFailed(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default: return false
        }
    }
}

/// Enum representing APIService result for View Models
enum APIServiceResult<T> {
    case result(T)
    case error(APIError)
}

/// API Service layee which used given network service to call network http requests
final class APIService {
    
    private var urlSessionService: NetworkService
    
    init(with urlSessionService: NetworkService) {
        self.urlSessionService = urlSessionService
    }
    
    /// API to fetch countries
    /// - Parameter completion: Completion Handler
    func fetchCountries(_ completion: @escaping (APIServiceResult<[Country]>) -> Void) {
        urlSessionService.execute(.counties) { response in
            let result = ResponseParser<[Country]>().handleResposne(response)
            completion(result)
        }
    }
    
    /// API to fetch provenances
    /// - Parameter completion: Completion Handler
    func fetchProvenance(for countryId: Int, completion: @escaping (APIServiceResult<[Provenance]>) -> Void) {
        urlSessionService.execute(.provenance(countryId)) { response in
            let result = ResponseParser<[Provenance]>().handleResposne(response)
            completion(result)
        }
    }
}
