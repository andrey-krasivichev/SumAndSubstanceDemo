//
//  ErrorHandler.swift
//  SumAndSubstanceDemo
//
//  Created by Andrey Krasivichev on 05.05.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import Foundation

typealias ErrorBlock = (Error) -> Void

protocol ErrorHandler {
    func handle(_ data: Error)
}

class ErrorHandlerFactory {
    static func emptyHandler() -> ErrorHandler {
        return self.handlerWithBlock { (_) in }
    }
    
    static func logHandler() -> ErrorHandler {
        return self.handlerWithBlock { (error) in
            print(">> error: \(error)")
        }
    }
    
    static func handlerWithBlock(_ block: @escaping ErrorBlock) -> ErrorHandler {
        return ErrorHandlerWithBlock(block: block)
    }
    
    static func compositeWithComponents(_ components: [ErrorHandler]) -> ErrorHandler {
        return self.handlerWithBlock { (error) in
            for component in components {
                component.handle(error)
            }
        }
    }
}

private class ErrorHandlerWithBlock: ErrorHandler {
    let errorBlock: ErrorBlock
    init(block: @escaping ErrorBlock) {
        self.errorBlock = block
    }
    
    // MARK: <ErrorHandler>
    func handle(_ error: Error) {
        self.errorBlock(error)
    }
}
