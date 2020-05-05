//
//  DataHandler.swift
//  SumAndSubstanceDemo
//
//  Created by Andrey Krasivichev on 05.05.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import Foundation

typealias DataBlock = (Data) -> Void

protocol DataHandler {
    func handle(_ data: Data)
}

class DataHandlerFactory {
    static func emptyHandler() -> DataHandler {
        return self.handlerWithBlock { (_) in }
    }
    
    static func logHandler() -> DataHandler {
        return self.handlerWithBlock { (data) in
            let dataAsString = String(data: data, encoding: String.Encoding.utf8) ?? ""
            print(">> data: \(dataAsString)")
        }
    }
    
    static func handlerWithBlock(_ block: @escaping DataBlock) -> DataHandler {
        return DataHandlerWithBlock(block: block)
    }
    
    static func dataHandlerWithExpectedResponse(_ apiResponse: ApiResponse) -> DataHandler {
        return self.handlerWithBlock { (data) in
            var response = apiResponse
            response.data = data
        }
    }
    
    static func compositeWithComponents(_ components: [DataHandler]) -> DataHandler {
        return self.handlerWithBlock { (data) in
            for handler in components {
                handler.handle(data)
            }
        }
    }
    
    static func jsonDataHandler(jsonHandler: ObjectHandler, parseErrorHandler: ErrorHandler) -> DataHandler {
        return DataToJsonSerializeHandler(objectHandler: jsonHandler, errorHandler: parseErrorHandler)
    }
}

private class DataHandlerWithBlock: DataHandler {
    let dataBlock: DataBlock
    init(block: @escaping DataBlock) {
        self.dataBlock = block
    }
    
    // MARK: <DataHandler>
    func handle(_ data: Data) {
        self.dataBlock(data)
    }
}

private class DataToJsonSerializeHandler: DataHandler {
    var objectHandler: ObjectHandler
    var errorHandler: ErrorHandler
    init(objectHandler: ObjectHandler, errorHandler: ErrorHandler) {
        self.objectHandler = objectHandler
        self.errorHandler = errorHandler
    }
    
    func handle(_ data: Data) {
        if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.fragmentsAllowed) {
            self.objectHandler.handle(jsonObject)
        } else {
            let dataString = String(data: data, encoding: String.Encoding.utf8) ?? "\(data.count)"
            print(">>> failed to parse json data: \(dataString)")
            let error = ErrorFactory.jsonParseError(message: dataString)
            self.errorHandler.handle(error)
        }
    }
}
