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
    
    static func singedRequestWithMethod(_ method: ApiMethod) -> ApiRequest {
        return SignedRequest(method: method)
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
        var defaultUrl = self.method.urlBase ?? baseUrl ?? AppCredentials.baseUrl
        defaultUrl.append(self.method.name)
        guard let url = URL(string: defaultUrl) else {
            fatalError("url must exist")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    private func makePOSTUrlRequest(baseUrl: String?) -> URLRequest {
        var defaultUrl = self.method.urlBase ?? baseUrl ?? AppCredentials.baseUrl
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

fileprivate struct AppCredentials {
    static let baseUrl: String = "https://test-api.sumsub.com"
    static let appToken: String = "tst:psSjTdUBSKXY5uHOvjSR0FbX.5Hab2HamdHVQMP937WWzRH1YO1T4D3PS"
    static let appSecret: String = "aUYa5ThpwhBw3hIsGroiZkJSeP0XmbS0"
}

fileprivate class SignedRequest: ApiRequest {
    var method: ApiMethod
    var dataHandler: DataHandler = DataHandlerFactory.logHandler()
    var errorHandler: ErrorHandler = ErrorHandlerFactory.logHandler()
    
    init(method: ApiMethod) {
        self.method = method
    }
    
    func makeUrlRequest(baseUrl: String?) -> URLRequest {
        
        var queryString = self.method.queryParameters.queryString()
        if queryString.count > 0 {
            queryString = "?".appending(queryString)
        }
        
        let urlBase = self.method.urlBase ?? baseUrl ?? AppCredentials.baseUrl
        let urlString = urlBase.appending(self.method.name).appending(queryString)
        guard let url = URL(string: urlString) else {
            fatalError("url must exist")
        }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(AppCredentials.appToken, forHTTPHeaderField: "X-App-Token")
        
        let timestampSeconds = Int(Date().timeIntervalSince1970)
        request.addValue("\(timestampSeconds)", forHTTPHeaderField: "X-App-Access-Ts")
        
        let methodType = self.method.type
        let path = self.method.name.appending(queryString)
        
        let data = Data()
        let signature = self.signatureForTimestamp(timestampSeconds, secret: AppCredentials.appSecret, method: methodType, path: path, body: data)
        request.addValue(signature, forHTTPHeaderField: "X-App-Access-Sig")
        request.httpMethod = methodType
        // can be improved later
        // request.httpBody = data
        // request.addValue("\(data.count)", forHTTPHeaderField: "Content-Length")
        return request
    }
    
    private func signatureForTimestamp(_ timestamp: Int, secret: String, method: String, path: String, body: Data) -> String {
        let stringToSign = "\(timestamp)\(method)\(path)"
        let signature = stringToSign.hmac(algorithm: CryptoAlgorithm.SHA256, key: secret)
        return signature
    }
}
