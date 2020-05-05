//
//  ApiService.swift
//  SumAndSubstanceDemo
//
//  Created by Andrey Krasivichev on 05.05.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import Foundation

class ApiService {
    
    let baseUrl: String = "https://test-api.sumsub.com"
    private var token: String?
    private let session: URLSession
    
    init(sessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.session = URLSession(configuration: sessionConfiguration)
    }
    
    func sendRequest(_ request: ApiRequest) {
        var urlRequest = request.makeUrlRequest(baseUrl: self.baseUrl)
        urlRequest = self.addHeaders(to: urlRequest)
        print(">>> ApiService: will make request: \(urlRequest)")
        self.loadRequest(urlRequest) { (result) in
            RedispatchToMainThread {
                switch result {
                case .success(let data):
                    request.dataHandler.handle(data)
                case .failure(let error):
                    request.errorHandler.handle(error)
                }
            }
        }
    }
    
    // MARK: Private
    private func loadRequest(_ request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        let requestToSend = self.addHeaders(to: request)
        let resultHandler: (Data?, URLResponse?, Error?) -> Void = { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                if statusCode != 200 {
                    // handle error
                    return
                }
            }
            
            if let data = data {
                completion(.success(data))
                return
            }
        }
        let task = self.session.dataTask(with: requestToSend, completionHandler: resultHandler)
        task.resume()
    }
    
    private func addHeaders(to request: URLRequest) -> URLRequest {
        var result = request
        var headers = result.allHTTPHeaderFields ?? [:]
        func addHeader(headers: inout [String: String], key: String, value: String) {
            if headers[key] == nil {
                headers[key] = value
            }
        }
//        addHeader(headers: &headers, key: "X-Device-Platform", value: "iOS")
//        addHeader(headers: &headers, key: "X-Device-Platform-Version", value: UIDevice.current.systemVersion)
//        addHeader(headers: &headers, key: "X-Auth-Token", value: self.token)
        result.allHTTPHeaderFields = headers
        return result
    }
}
