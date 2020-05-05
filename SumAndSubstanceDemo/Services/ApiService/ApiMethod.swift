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
    var url: String? { get }
    var type: String { get }
    func postData() -> Data
}

class ApiMethodFactory {
    static func commonUrlPrefix() -> String {
        return "test-api.sumsub.com"
    }
    
    static func login(base64: String) -> ApiMethod {
        let methodName = "/resources/auth/login"
        return DefaultMethod(name: methodName)
    }
    
}

fileprivate class DefaultMethod: ApiMethod {
    var name: String
    var url: String?
    func postData() -> Data {
        return Data()
    }
    var type: String = "GET"
    
    init(name: String) {
        self.name = name
    }
}
