//
//  ResponseParser.swift
//  Countries
//
//  Created by Nirmal Choudhari on 24/05/21.
//

import Foundation

/// A Generic API parser which accepts the Template type to decode and parse given resposne
struct ResponseParser<T> where T: Codable {
    
    
    /// Computes the APIService result based on the given API resposne
    /// - Parameter resposne: API resposne from Network Layer
    /// - Returns: APIService Result of template type
    func handleResposne(_ resposne: APIResponse) -> APIServiceResult<T> {
        if let error = resposne.error  {
            return APIServiceResult.error(.fetchFailed(error))
        }
        guard let data = resposne.data else {
            return APIServiceResult.error(.noData)
        }
        guard let parsedResposne = parse(responseData: data) else {
            return APIServiceResult.error(.serelization)
        }
        return APIServiceResult.result(parsedResposne)
    }
    
    private func parse(responseData: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(T.self, from: responseData)
            return result
        } catch {
            return nil
        }
    }
}
