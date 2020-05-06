//
//  ApiMethod.swift
//  SumAndSubstanceDemo
//
//  Created by Andrey Krasivichev on 05.05.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import Foundation

protocol ApiMethod {
    var name: String { get }
    var queryParameters: [String : Any] { get }
    var urlBase: String? { get }
    var type: String { get }
    func postData() -> Data
}

class ApiMethodFactory {
    static func commonUrlBase() -> String {
        return "https://test-api.sumsub.com"
    }
    
    static func login(base64: String) -> ApiMethod {
        let methodName = "/resources/auth/login"
        return DefaultMethod(name: methodName)
    }
    
    static func accessTokenForApplicantId(_ applicantId: String) -> ApiMethod {
        let methodName = "/resources/accessTokens"
        let method = DefaultMethod(name: methodName, parameters: ["applicantId" : applicantId])
        method.type = "POST"
        method.urlBase = self.commonUrlBase()
        return method
    }
}

fileprivate class DefaultMethod: ApiMethod {
    var name: String
    var urlBase: String?
    var queryParameters: [String : Any]
    
    func postData() -> Data {
        return Data()
    }
    var type: String = "GET"
    
    init(name: String, parameters: [String : Any] = [:]) {
        self.name = name
        self.queryParameters = parameters
    }
}
