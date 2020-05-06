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

// concrete expected complex responses can be added here
