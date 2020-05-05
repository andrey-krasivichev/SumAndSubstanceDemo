//
//  ErrorFactory.swift
//  SumAndSubstanceDemo
//
//  Created by Andrey Krasivichev on 05.05.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import Foundation

class ErrorFactory {
    static func jsonParseError(message: String? = nil) -> Error {
        return JsonParseError(message: message)
    }
}

fileprivate class BasicError: Error {
    let message: String?
    init(message: String?) {
        self.message = message
    }
}

fileprivate class JsonParseError: BasicError {
}
