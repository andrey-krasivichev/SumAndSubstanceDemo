//
//  LoginVC.swift
//  SumAndSubstanceDemo
//
//  Created by Andrey Krasivichev on 05.05.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import UIKit

class LoginVC: ScrollViewController {

    lazy private(set) var loginTextField: LabeledTextFieldView = {
        let textView = LabeledTextFieldView()
        textView.label.text = "Login"
        textView.textField.placeholder = "Enter login"
        self.scrollView.addSubview(textView)
        return textView
    }()
    
    lazy private(set) var passwordTextField: LabeledTextFieldView = {
        let textView = LabeledTextFieldView()
        textView.label.text = "Password"
        textView.textField.placeholder = "Enter password"
        self.scrollView.addSubview(textView)
        return textView
    }()
    
    lazy private(set) var applicantIdentifierTextField: LabeledTextFieldView = {
        let textView = LabeledTextFieldView()
        textView.label.text = "Applicant ID"
        textView.textField.placeholder = "Enter Identifier"
        self.scrollView.addSubview(textView)
        return textView
    }()
    
    lazy private(set) var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: UIControl.State.normal)
        button.setTitleColor(StyleSheet.Colors.mainGreen, for: UIControl.State.normal)
        button.setContentCompressionResistancePriority(priority: UILayoutPriority.required)
        button.addTarget(self, action: #selector(continueButtonPressed(_:)), for: UIControl.Event.touchUpInside)
        button.applyHalfVisibilityOnStateChanged()
        self.scrollView.addSubview(button)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupKeyboardHandler()
    }

    override func setupConstraints() {
        super.setupConstraints()
        
        self.loginTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.scrollView).offset(StyleSheet.Offsets.xxxl)
            make.left.right.equalTo(self.scrollView).inset(StyleSheet.Offsets.l)
        }
        
        self.passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginTextField.snp.bottom).offset(StyleSheet.Offsets.l)
            make.left.right.equalTo(self.loginTextField)
        }
        
        self.applicantIdentifierTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(StyleSheet.Offsets.l)
            make.left.right.height.equalTo(self.passwordTextField)
        }
        
        self.continueButton.snp.makeConstraints { (make) in
            make.width.equalTo(self.view).multipliedBy(0.5)
            make.centerX.equalTo(self.scrollView)
            make.top.equalTo(self.applicantIdentifierTextField.snp.bottom).offset(StyleSheet.Offsets.l)
            make.bottom.equalTo(self.scrollView).inset(StyleSheet.Offsets.l).priorityHigh()
        }
    }
    
    @objc private func continueButtonPressed(_ button: UIButton) {
        print("button pressed")
    }
}
