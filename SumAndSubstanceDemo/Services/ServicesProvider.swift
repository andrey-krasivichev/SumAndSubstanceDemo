//
//  ServicesProvider.swift
//  SumAndSubstanceDemo
//
//  Created by Andrey Krasivichev on 05.05.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import Foundation

protocol ServicesProviderUsage {
    var servicesProvider: ServicesProvider { get }
    var uiService: UIService { get }
    var apiService: ApiService { get }
}

class ServicesProvider {
    lazy private(set) var uiService: UIService = {
        return UIService(servicesProvider: self)
    }()
    
    lazy private(set) var notificationCenter: NotificationCenter = {
        return NotificationCenter()
    }()
    
    lazy private(set) var apiService: ApiService = {
        return ApiService()
    }()
}

extension ServicesProviderUsage {
    var uiService: UIService {
        return self.servicesProvider.uiService
    }
    
    var apiService: ApiService {
        return self.servicesProvider.apiService
    }
}
