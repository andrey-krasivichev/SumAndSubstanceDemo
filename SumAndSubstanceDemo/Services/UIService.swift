//
//  UIService.swift
//  FootballData
//
//  Created by Andrey Krasivichev on 02.04.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import Foundation
import UIKit

class UIService: NSObject, ServicesProviderUsage {

    unowned var servicesProvider: ServicesProvider

    init(servicesProvider: ServicesProvider) {
        self.servicesProvider = servicesProvider
        super.init()
    }

    lazy private(set) var appWindow: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let startVC = LoginVC(servicesProvider: self.servicesProvider)
        window.rootViewController = startVC
        return window
    }()
}
