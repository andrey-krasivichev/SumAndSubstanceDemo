//
//  TextFieldFactory.swift
//  SumAndSubstanceDemo
//
//  Created by Andrey Krasivichev on 05.05.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import UIKit

extension UITextField {
    static func defaultTextField() -> UITextField {
        let field = UITextField()
        field.layer.cornerRadius = StyleSheet.Offsets.xs
        field.layer.borderWidth = 1.0
        field.layer.borderColor = StyleSheet.Colors.mainBlack40.cgColor
        field.clipsToBounds = true
        field.setContentHuggingPriority(UILayoutPriority.defaultLow, for: NSLayoutConstraint.Axis.horizontal)
        return field
    }
}
