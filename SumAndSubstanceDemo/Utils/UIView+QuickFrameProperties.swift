//
//  Created by Andrey Krasivichev on 02.04.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import UIKit

extension UIView {
    // frame
    var size: CGSize    {   return self.frame.size          }
    var width: CGFloat  {   return self.frame.size.width    }
    var height: CGFloat {   return self.frame.size.height   }
    var left: CGFloat   {   return self.frame.origin.x      }
    var top: CGFloat    {   return self.frame.origin.y      }
    var right: CGFloat  {   return self.frame.origin.x + self.width      }
    var bottom: CGFloat {   return self.frame.origin.y + self.height     }
    
    // bounds
    var boundsWidth: CGFloat {  return self.bounds.size.width   }
    var boundsHeight: CGFloat {  return self.bounds.size.height   }
    
    var centerX: CGFloat { return self.center.x }
    var centerY: CGFloat { return self.center.y }
}

extension UIView {
    func bringToFront() {
        self.superview?.bringSubviewToFront(self)
    }
    
    func sendToBack() {
        self.superview?.sendSubviewToBack(self)
    }
}

extension UIWindow {
    static func currentSafeAreaInsets() -> UIEdgeInsets {
        var insets = UIEdgeInsets.zero
        guard let window = UIApplication.shared.keyWindow else {
            return insets
        }
        
        if #available(iOS 11.0, *) {
            insets = window.safeAreaInsets
        }
        
        if UIDevice.isSystemVersionLowerThan(12.0) {
            let statusBarInset: CGFloat = 20.0
            insets.top += statusBarInset
        }
        
        return insets
    }
}

extension UIView {
    var cornerRadius: CGFloat {
        set {
            self.layer.cornerRadius = newValue
        }
        get {
            return self.layer.cornerRadius
        }
    }
}
