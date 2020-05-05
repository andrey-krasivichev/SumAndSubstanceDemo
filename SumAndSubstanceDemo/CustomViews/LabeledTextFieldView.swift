//
//  LabeledTextField.swift
//  SumAndSubstanceDemo
//
//  Created by Andrey Krasivichev on 05.05.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import UIKit

class LabeledTextFieldView: UIView {

    lazy private(set) var label: UILabel = {
        let label = UILabel()
        label.font = StyleSheet.Fonts.regular12
        label.setContentCompressionResistancePriority(priority: UILayoutPriority.required)
        self.addSubview(label)
        return label
    }()

    lazy private(set) var textField: UITextField = {
        let textField = UITextField.defaultTextField()
        self.addSubview(textField)
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        self.label.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self).inset(StyleSheet.Offsets.m)
        }
        
        self.textField.snp.makeConstraints { (make) in
            make.top.equalTo(self.label.snp.bottom).offset(StyleSheet.Offsets.xxs)
            make.height.equalTo(30.0)
            make.left.bottom.right.equalTo(self).inset(StyleSheet.Offsets.m)
        }
    }
}
