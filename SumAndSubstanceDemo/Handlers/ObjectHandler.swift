//
//  ObjectHandler.swift
//  SumAndSubstanceDemo
//
//  Created by Andrey Krasivichev on 05.05.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import Foundation

typealias AnyObjectBlock = (Any) -> Void

protocol ObjectHandler {
    func handle(_ object: Any)
}

class ObjectHandlerFactory {
    static func handlerWithBlock(_ block: @escaping AnyObjectBlock) -> ObjectHandler {
        return ObjectHandlerWithBlock(block: block)
    }
}

private class ObjectHandlerWithBlock: ObjectHandler {
    let block: AnyObjectBlock
    init(block: @escaping AnyObjectBlock) {
        self.block = block
    }
    
    func handle(_ object: Any) {
        self.block(object)
    }
}
