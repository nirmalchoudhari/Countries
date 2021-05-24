//
//  MockURLSession.swift
//  CountriesTests
//
//  Created by Nirmal Choudhari on 24/05/21.
//

import Foundation

typealias SessionResposne = (data:Data?, res:URLResponse?, err:Error?)
typealias SessionCompletion = (SessionResposne) -> Void

class MockURLSession: URLSession {
    var resposne: SessionResposne?
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionTask { [weak self] in
            completionHandler(self?.resposne?.data, self?.resposne?.res, self?.resposne?.err)
        }
    }
}
