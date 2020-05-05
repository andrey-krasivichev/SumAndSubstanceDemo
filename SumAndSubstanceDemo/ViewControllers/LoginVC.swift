//
//  LoginVC.swift
//  SumAndSubstanceDemo
//
//  Created by Andrey Krasivichev on 05.05.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import UIKit

class LoginVC: ScrollViewController {

    lazy private(set) var loginTextField: UITextField = {
        let textField = UITextField.defaultTextField()
        textField.placeholder = "Login"
        self.scrollView.addSubview(textField)
        return textField
    }()
    
    lazy private(set) var passwordTextField: UITextField = {
        let textField = UITextField.defaultTextField()
        textField.placeholder = "Password"
        self.scrollView.addSubview(textField)
        return textField
    }()
    
    lazy private(set) var applicantIdentifierTextField: UITextField = {
        let textField = UITextField.defaultTextField()
        textField.placeholder = "Applicant ID"
        self.scrollView.addSubview(textField)
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func setupConstraints() {
        super.setupConstraints()
        self.loginTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.scrollView).offset(StyleSheet.Offsets.l)
            make.left.right.equalTo(self.scrollView).inset(StyleSheet.Offsets.l)
            make.height.equalTo(44.0)
        }
        
        self.passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginTextField.snp.bottom).offset(StyleSheet.Offsets.l)
            make.left.right.height.equalTo(self.loginTextField)
        }
        
        self.applicantIdentifierTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(StyleSheet.Offsets.l)
            make.left.right.height.equalTo(self.passwordTextField)
            make.bottom.equalTo(self.scrollView).inset(StyleSheet.Offsets.l).priorityHigh()
        }
    }
}
