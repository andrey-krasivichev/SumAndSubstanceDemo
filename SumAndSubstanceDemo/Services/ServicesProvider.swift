//
//  ServicesProvider.swift
//  FootballData
//
//  Created by Andrey Krasivichev on 02.04.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import Foundation

protocol ServicesProviderUsage {
    var servicesProvider: ServicesProvider { get }
    var uiService: UIService { get }
}

class ServicesProvider {
    lazy private(set) var uiService: UIService = {
        return UIService(servicesProvider: self)
    }()
    
    lazy private(set) var notificationCenter: NotificationCenter = {
        return NotificationCenter()
    }()
}

extension ServicesProviderUsage {
    var uiService: UIService {
        return self.servicesProvider.uiService
    }
}
