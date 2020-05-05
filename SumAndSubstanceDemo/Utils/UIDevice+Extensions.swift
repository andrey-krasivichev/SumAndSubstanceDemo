//
//  Created by Andrey Krasivichev on 02.04.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import UIKit

extension UIDevice {
    static func isSystemVersionLowerThan(_ version: Double) -> Bool {
        return UIDevice.current.systemVersion.compare(String(version), options: .numeric) == .orderedAscending
    }
}
