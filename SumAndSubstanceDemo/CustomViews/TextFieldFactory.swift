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
        field.clipsToBounds = true
        return field
    }
}
