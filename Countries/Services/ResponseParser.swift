//
//  ResponseParser.swift
//  Countries
//
//  Created by Nirmal Choudhari on 24/05/21.
//

import Foundation

struct ResponseParser<T> where T: Codable {
    
    func handleResposne(_ resposne: APIResponse) -> APIServiceResult<T> {
        if let error = resposne.error  {
            return APIServiceResult.error(.fetchFailed(error))
        }
        
        guard let parsedResposne = parse(responseData: resposne.data) else {
            return APIServiceResult.error(.noData)
        }
        return APIServiceResult.result(parsedResposne)
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
