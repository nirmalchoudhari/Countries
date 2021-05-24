//
//  URLService.swift
//  Countries
//
//  Created by Nirmal Choudhari on 22/05/21.
//

import Foundation

protocol NetworkService {
    func execute(_ requestType: RequestType, responseQueue: DispatchQueue, completion: @escaping (APIResponse) -> Void)
    func execute(_ requestType: RequestType, completion: @escaping (APIResponse) -> Void)
}

struct APIResponse {
    let data: Data?
    let error: Error?
}

final class URLSessionService: NetworkService {
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    func execute(_ requestType: RequestType, completion: @escaping (APIResponse) -> Void) {
        execute(requestType, responseQueue: .main, completion: completion)
    }
    
    func execute(_ requestType: RequestType, responseQueue: DispatchQueue, completion: @escaping (APIResponse) -> Void) {
        dataTask?.cancel()
        guard let url = URL(string: requestType.urlString) else { return }
        
        dataTask = defaultSession.dataTask(with: url, completionHandler: { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            let apiResponse = APIResponse(data: data, error: error)
            responseQueue.async {
                completion(apiResponse)
            }
        })
        
        dataTask?.resume()
    }
}
