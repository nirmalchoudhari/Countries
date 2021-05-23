//
//  APIService.swift
//  Countries
//
//  Created by Nirmal Choudhari on 22/05/21.
//

import Foundation

enum APIError: Error {
    case noData
    case fetchFailed(Error)
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

class APIServiceResult<T> {
    var result: T?
    var error: APIError?
    init(result: T?, error: APIError?) {
        self.result = result
        self.error = error
    }
}

struct ResponseParser<T> where T: Codable {
    
    func handleResposne(_ resposne: APIResponse) -> APIServiceResult<T> {
        if let error = resposne.error  {
            return APIServiceResult(result: nil, error: .fetchFailed(error))
        }
        
        guard let countires = parse(responseData: resposne.data) else {
            return APIServiceResult(result: nil, error: .noData)
        }
        return APIServiceResult(result: countires, error: nil)
    }
    
    private func parse(responseData: Data?) -> T? {
        guard let data = responseData else {
            return nil
        }
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch let error {
            print(error)
            return nil
        }
    }
}
