//
//  Created by Andrey Krasivichev on 02.04.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import UIKit

// convinience methods for quick view setup
extension UIView {
    public func setContentPriorityRequired() {
        self.setContentPriority(priority: .required)
    }
    
    public func setContentPriority(priority: UILayoutPriority) {
        self.setContentCompressionResistancePriority(priority: priority)
        self.setContentHuggingPriority(priority: priority)
    }
    
    public func setContentCompressionResistancePriority(priority: UILayoutPriority) {
        self.setContentCompressionResistancePriority(priority, for: NSLayoutConstraint.Axis.horizontal)
        self.setContentCompressionResistancePriority(priority, for: NSLayoutConstraint.Axis.vertical)
    }
    
    public func setContentHuggingPriority(priority: UILayoutPriority) {
        self.setContentHuggingPriority(priority, for: NSLayoutConstraint.Axis.horizontal)
        self.setContentHuggingPriority(priority, for: NSLayoutConstraint.Axis.vertical)
    }
}

extension UIView {
    public func activateEdgeConstraints(toView: UIView) {
        NSLayoutConstraint.activate([toView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                     toView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                     toView.topAnchor.constraint(equalTo: self.topAnchor),
                                     toView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
    }
}
