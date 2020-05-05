//
//  AppDelegate.swift
//  SumAndSubstanceDemo
//
//  Created by Andrey Krasivichev on 05.05.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    lazy private var servicesProvider: ServicesProvider = {
        return ServicesProvider()
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let appWindow = self.servicesProvider.uiService.appWindow
        self.window = appWindow
        appWindow.makeKeyAndVisible()
        return true
    }
}
