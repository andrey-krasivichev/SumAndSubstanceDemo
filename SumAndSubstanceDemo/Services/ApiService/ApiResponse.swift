//
//  ApiResponse.swift
//  SumAndSubstanceDemo
//
//  Created by Andrey Krasivichev on 05.05.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import Foundation

protocol ApiResponse {
    var data: Data? { get set }
    
    var isValid: Bool { get }
    var success: Bool { get }
    var errors: [Error] { get }
}

class LoginResponse: ApiResponse {
    var data: Data? {
        didSet {
            if let data = self.data {
                self.parseData(data)
            }
        }
    }
    private(set) var token: String?
    
    var isValid: Bool = false
    var success: Bool = false
    var errors: [Error] = []
    
    private func parseData(_ data: Data) {
        
    }
}
