//
//  UIService.swift
//  SumAndSubstanceDemo
//
//  Created by Andrey Krasivichev on 05.05.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import Foundation
import UIKit
import IdensicMobileSDK

class UIService: NSObject, ServicesProviderUsage {

    unowned var servicesProvider: ServicesProvider
    private var idensicSDK: SNSMobileSDK?
    
    init(servicesProvider: ServicesProvider) {
        self.servicesProvider = servicesProvider
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(invalidateSizeOfTextField(_:)), name: UITextField.textDidChangeNotification, object: nil)
    }

    lazy private(set) var appWindow: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let startVC = LoginVC(servicesProvider: self.servicesProvider)
        window.rootViewController = startVC
        return window
    }()
    
    func showIdensicScreen(token: String, applicantId: String) {
        
        let sdk = SNSMobileSDK(baseUrl: self.apiService.baseUrl, applicantId: applicantId, accessToken: token, locale: nil, supportEmail: nil)
        self.idensicSDK = sdk
        guard sdk.isReady else {
            self.showErrorAlertMessage(sdk.verboseStatus)
            return
        }
        guard let idensicScreen = self.idensicSDK?.mainVC else {
            self.showErrorAlertMessage("Failed to initialize Idensic screen")
            return
        }
        
        self.topVC().present(idensicScreen, animated: true, completion: nil)
    }
    
    func showErrorAlertMessage(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.cancel, handler: { [weak alert] (_) in
            alert?.dismiss(animated: true, completion: nil)
        }))
        
        self.topVC().present(alert, animated: true, completion: nil)
    }
    
    private func topVC() -> UIViewController {
        guard let vc = self.appWindow.rootViewController else {
            fatalError("controller must exist")
        }
        return vc.topVC()
    }
    
    @objc private func invalidateSizeOfTextField(_ notification: Notification) {
        guard let field = notification.object as? UITextField else {
            return
        }
        field.invalidateIntrinsicContentSize()
    }
}

extension UIViewController {
    func topVC() -> UIViewController {
        var presentedVC = self
        while let nextPresented = presentedVC.presentedViewController {
            presentedVC = nextPresented
        }
        return presentedVC
    }
}

extension UINavigationController {
    func topNC() -> UINavigationController {
        var topNC = self
        var topPresentedVC: UIViewController = self
        while let nextPresentedVC = topPresentedVC.presentedViewController {
            if let navController = nextPresentedVC as? UINavigationController {
                topNC = navController
            }
            topPresentedVC = nextPresentedVC
        }
        return topNC
    }
}
