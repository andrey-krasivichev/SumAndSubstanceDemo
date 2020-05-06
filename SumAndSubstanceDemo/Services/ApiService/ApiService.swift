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
    private let session: URLSession
    
    init(sessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.session = URLSession(configuration: sessionConfiguration)
    }
    
    func sendRequest(_ request: ApiRequest) {
        let urlRequest = request.makeUrlRequest(baseUrl: self.baseUrl)
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
        let resultHandler: (Data?, URLResponse?, Error?) -> Void = { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                if statusCode != 200 {
                    completion(.failure(ErrorFactory.apiError(responseCode: statusCode, data: data)))
                    return
                }
            }
            
            if let data = data {
                completion(.success(data))
                return
            }
        }
        let task = self.session.dataTask(with: request, completionHandler: resultHandler)
        task.resume()
    }
}
