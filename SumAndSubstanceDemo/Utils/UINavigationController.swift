//
//  Created by Andrey Krasivichev on 02.04.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    open override var childForStatusBarStyle: UIViewController? {
        return self.viewControllers.last
    }
    
    func pushViewControllerAsRoot(viewController: UIViewController) {
        self.setViewControllers([viewController], animated: true)
    }

    func pushViewControllersAsRoot(viewControllers: [UIViewController]) {
        self.setViewControllers(viewControllers, animated: true)
    }
}
