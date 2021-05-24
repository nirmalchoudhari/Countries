//
//  URLService.swift
//  Countries
//
//  Created by Nirmal Choudhari on 22/05/21.
//

import Foundation

/// Protocol for Network Service which can be implemented and injected
protocol NetworkService {
    func execute(_ requestType: RequestType, responseQueue: DispatchQueue, completion: @escaping (APIResponse) -> Void)
    func execute(_ requestType: RequestType, completion: @escaping (APIResponse) -> Void)
}

/// Enum to represent API resposne
struct APIResponse {
    let data: Data?
    let error: Error?
}

/// NetworkService implementation using URLSession
final class URLSessionService: NetworkService {
    
    private let defaultSession: URLSession
    private var dataTask: URLSessionDataTask?
    
    /// Initializer
    /// - Parameter session: oprional session value. If not provided, uses a default session
    init(session: URLSession = URLSession(configuration: .default)) {
        defaultSession = session
    }
    
    /// Executes the API request based on the request type
    /// - Parameters:
    ///   - requestType: a request type for a request
    ///   - completion: completion handler returning APIResposne
    func execute(_ requestType: RequestType, completion: @escaping (APIResponse) -> Void) {
        execute(requestType, responseQueue: .main, completion: completion)
    }
    
    /// Executes the API request based on the request type
    /// - Parameters:
    ///   - requestType: a request type for a request
    ///   - responseQueue: A dispatch queue on which resposne is requested, defaults to main queue
    ///   - completion: completion handler returning APIResposne
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
