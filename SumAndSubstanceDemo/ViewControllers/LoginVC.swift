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
        textView.textField.addTarget(self, action: #selector(enableButtonIfFieldsAreValid), for: .editingChanged)
        textView.textField.placeholder = "Enter login"
        self.scrollView.addSubview(textView)
        return textView
    }()
    
    lazy private(set) var passwordTextField: LabeledTextFieldView = {
        let textView = LabeledTextFieldView()
        textView.label.text = "Password"
        textView.textField.placeholder = "Enter password"
        textView.textField.addTarget(self, action: #selector(enableButtonIfFieldsAreValid), for: .editingChanged)
        self.scrollView.addSubview(textView)
        return textView
    }()
    
    lazy private(set) var applicantIdentifierTextField: LabeledTextFieldView = {
        let textView = LabeledTextFieldView()
        textView.label.text = "Applicant ID"
        textView.textField.placeholder = "Enter Identifier"
        textView.textField.addTarget(self, action: #selector(enableButtonIfFieldsAreValid), for: .editingChanged)
        self.scrollView.addSubview(textView)
        return textView
    }()
    
    lazy private(set) var continueButton: LoadingSupportButton = {
        let button = LoadingSupportButton()
        button.setTitle("Continue", for: UIControl.State.normal)
        button.setTitleColor(StyleSheet.Colors.mainGreen, for: UIControl.State.normal)
        button.setTitleColor(StyleSheet.Colors.mainGreen.withAlphaComponent(0.5), for: UIControl.State.disabled)
        button.setContentCompressionResistancePriority(priority: UILayoutPriority.required)
        button.addTarget(self, action: #selector(continueButtonPressed(_:)), for: UIControl.Event.touchUpInside)
        button.applyHalfVisibilityOnStateChanged()
        button.isEnabled = false
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
        guard
            var name = self.loginTextField.textField.text,
            var pass = self.passwordTextField.textField.text,
            var applicantId = self.applicantIdentifierTextField.textField.text else {
            print("Some field is empty")
            return
        }
        self.continueButton.startLoadingAnimation()
        
        // Test data, remove!
        name = name.count < 1 ? "ios_test_task_andrey_krasivichev_test" : name
        pass = pass.count < 1 ? "Xahpow-1cuwku-qopvec" : pass
        applicantId = applicantId.count < 1 ? "5ea987670a975a052caea49c" : applicantId
        
        var loginRequest: ApiRequest = ApiRequestFactory.loginRequestWithUsername(name, password: pass)
        let successHandler: ObjectHandler = ObjectHandlerFactory.handlerWithBlock { [weak self] (info) in
            guard
                let self = self,
                let answer = info as? [String: Any],
                let token = answer.stringForKey("payload"),
                token.count > 0
            else {
                print("no required answer")
                return
            }
            self.uiService.showIdensicScreen(token: token, applicantId: applicantId)
            self.continueButton.stopLoadingAnimation()
        }
        let errorHandler = ErrorHandlerFactory.handlerWithBlock { [weak self] (error) in
            guard let self = self else {
                return
            }
            self.uiService.showErrorAlertMessage(error.localizedDescription)
            self.continueButton.stopLoadingAnimation()
        }
        loginRequest.dataHandler = DataHandlerFactory.jsonDataHandler(jsonHandler: successHandler, parseErrorHandler: errorHandler)
        loginRequest.errorHandler = errorHandler
        self.apiService.sendRequest(loginRequest)
    }
    
    @objc private func enableButtonIfFieldsAreValid() {
        var shouldEnable = (self.loginTextField.textField.text?.count ?? 0) > 0
        shouldEnable = shouldEnable && (self.passwordTextField.textField.text?.count ?? 0) > 0
        shouldEnable = shouldEnable && (self.applicantIdentifierTextField.textField.text?.count ?? 0) > 0
        self.continueButton.isEnabled = shouldEnable
    }
}
