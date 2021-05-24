//
//  APIService.swift
//  Countries
//
//  Created by Nirmal Choudhari on 22/05/21.
//

import Foundation

enum APIError: LocalizedError {
    case noData
    case fetchFailed(Error)
    
    public var errorDescription: String? {
        switch self {
        case .noData:
            return "No Data Available"
        case .fetchFailed(let error):
            return error.localizedDescription
        }
    }
}

enum APIServiceResult<T> {
    case result(T)
    case error(APIError)
}

final class APIService {
    
    private var urlSessionService: NetworkService
    
    init(with urlSessionService: NetworkService) {
        self.urlSessionService = urlSessionService
    }
    
    func fetchCountries(_ completion: @escaping (APIServiceResult<[Country]>) -> Void) {
        urlSessionService.execute(.counties) { response in
            let result = ResponseParser<[Country]>().handleResposne(response)
            completion(result)
        }
    }
    
    func fetchProvenance(for countryId: Int, completion: @escaping (APIServiceResult<[Provenance]>) -> Void) {
        urlSessionService.execute(.provenance(countryId)) { response in
            let result = ResponseParser<[Provenance]>().handleResposne(response)
            completion(result)
        }
    }
}
