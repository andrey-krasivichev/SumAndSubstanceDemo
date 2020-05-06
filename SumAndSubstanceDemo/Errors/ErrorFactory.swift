//
//  ErrorFactory.swift
//  SumAndSubstanceDemo
//
//  Created by Andrey Krasivichev on 05.05.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import Foundation

extension Error {
    var info: String {
        if let error = self as? MessageProvider {
            return error.message
        }
        return ""
    }
}

class ErrorFactory {
    static func jsonParseError(message: String? = nil) -> Error {
        let parseErrorMessageDefault = message ?? "Failed to parse JSON object"
        return JsonParseError(message: parseErrorMessageDefault)
    }
    
    static func apiError(responseCode: Int, data: Data?) -> Error {
        guard let data = data else {
            return UnknownApiError(code: responseCode)
        }
        let internalCode = self.parseErrorFromAnswer(data)
        if let code = internalCode.code, let description = internalCode.description {
            return ApiError(responseCode: responseCode, statusCode: code, message: description)
        }
        return UnknownApiError(code: responseCode)
    }
    
    private static func parseErrorFromAnswer(_ data: Data) -> (code: Int?, description: String?) {
        if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.fragmentsAllowed),
            let info = jsonObject as? [String: Any],
            let code = info.intForKey("code"),
            let description = info.stringForKey("description") {
            return (code, description)
        }
        return (nil, nil)
    }
}

fileprivate protocol MessageProvider {
    var message: String { get }
}

fileprivate class BasicError: Error, MessageProvider {
    var message: String
    init(message: String?) {
        self.message = message ?? ""
    }
}

fileprivate class JsonParseError: BasicError {
}

fileprivate class ApiError: BasicError {
    let responseCode: Int
    let statusCode: Int
    
    init(responseCode: Int, statusCode: Int, message: String) {
        self.responseCode = responseCode
        self.statusCode = statusCode
        let customMessage = "Code: \(statusCode), Message: \(message)"
        super.init(message: customMessage)
    }
}

fileprivate class UnknownApiError: BasicError {
    let code: Int
    
    init(code: Int) {
        self.code = code
        super.init(message: "Unknown Api Error")
    }    
}
