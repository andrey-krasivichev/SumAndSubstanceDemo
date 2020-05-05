//
//  ApiRequest.swift
//  SumAndSubstanceDemo
//
//  Created by Andrey Krasivichev on 05.05.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import Foundation

protocol ApiRequest {
    var method: ApiMethod { get }
    var dataHandler: DataHandler { get set }
    var errorHandler: ErrorHandler { get set }
    func makeUrlRequest(baseUrl: String?) -> URLRequest
}

class ApiRequestFactory {
    static func requestWithMethod(_ method: ApiMethod, dataHandler: DataHandler) -> ApiRequest {
        let request = ApiRequestDefault(method: method)
        request.dataHandler = dataHandler
        return request
    }
    
    static func requestWithMethod(_ method: ApiMethod, dataHandler: DataHandler, errorHandler: ErrorHandler) -> ApiRequest {
        var request = self.requestWithMethod(method, dataHandler: dataHandler)
        request.errorHandler = errorHandler
        return request
    }
    
    static func loginRequestWithUsername(_ userName: String, password: String) -> ApiRequest {
        let base64: String = "\(userName):\(password)".encodeToBase64() ?? ""
        return LoginRequest(base64: base64)
    }
}

fileprivate class ApiRequestDefault: ApiRequest {
    var method: ApiMethod
    var dataHandler: DataHandler = DataHandlerFactory.emptyHandler()
    var errorHandler: ErrorHandler = ErrorHandlerFactory.emptyHandler()
    
    init(method: ApiMethod) {
        self.method = method
    }
    
    func makeUrlRequest(baseUrl: String?) -> URLRequest {
        if self.method.type.caseInsensitiveCompare("get") == ComparisonResult.orderedSame {
            return self.makeGETUrlRequest(baseUrl: baseUrl)
        }
        return self.makePOSTUrlRequest(baseUrl: baseUrl)
    }
    
    private func makeGETUrlRequest(baseUrl: String?) -> URLRequest {
        var defaultUrl = self.method.url ?? baseUrl ?? ""
        defaultUrl.append(self.method.name)
        guard let url = URL(string: defaultUrl) else {
            fatalError("url must exist")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    private func makePOSTUrlRequest(baseUrl: String?) -> URLRequest {
        var defaultUrl = self.method.url ?? baseUrl ?? ""
        defaultUrl.append(self.method.name)
        guard let url = URL(string: defaultUrl) else {
            fatalError("url must exist")
        }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpMethod = "POST"
        let data = self.method.postData()
        request.httpBody = data
        request.addValue("\(data.count)", forHTTPHeaderField: "Content-Length")
        return request
    }
}

fileprivate class LoginRequest: ApiRequest {
    private let base64: String
    
    var method: ApiMethod
    var dataHandler: DataHandler = DataHandlerFactory.logHandler()
    var errorHandler: ErrorHandler = ErrorHandlerFactory.logHandler()
    
    init(base64: String) {
        self.base64 = base64
        self.method = ApiMethodFactory.login(base64: base64)
    }
    
    func makeUrlRequest(baseUrl: String?) -> URLRequest {
        return self.makePOSTUrlRequest(baseUrl: baseUrl)
    }
    
    private func makePOSTUrlRequest(baseUrl: String?) -> URLRequest {
        let urlString = "https://test-api.sumsub.com/resources/auth/login"
        guard let url = URL(string: urlString) else {
            fatalError("url must exist")
        }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpMethod = "POST"
        let data = Data()
        request.httpBody = data
        request.addValue("\(data.count)", forHTTPHeaderField: "Content-Length")
        request.addValue("Basic \(self.base64)", forHTTPHeaderField: "Authorization")
        return request
    }
}
