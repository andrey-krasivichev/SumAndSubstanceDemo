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
            make.left.right.equalTo(self.view).inset(StyleSheet.Offsets.l)
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
        
        let debugButton = UIButton()
        self.view.addSubview(debugButton)
        debugButton.addTarget(self, action: #selector(fillTestData), for: UIControl.Event.touchUpInside)
        debugButton.snp.makeConstraints { (make) in
            make.bottom.right.equalTo(self.view)
            make.size.equalTo(44.0)
        }
    }
    
    @objc private func continueButtonPressed(_ button: UIButton) {
        guard
            let name = self.loginTextField.textField.text, name.count > 0,
            let pass = self.passwordTextField.textField.text, pass.count > 0,
            let applicantId = self.applicantIdentifierTextField.textField.text else {
            return
        }
        self.continueButton.startLoadingAnimation()
        
        let accessTokenMethod = ApiMethodFactory.accessTokenForApplicantId(applicantId)
        var loginRequest: ApiRequest = ApiRequestFactory.singedRequestWithMethod(accessTokenMethod)
        let successHandler: ObjectHandler = ObjectHandlerFactory.handlerWithBlock { [weak self] (info) in
            guard
                let self = self,
                let answer = info as? [String: Any],
                let token = answer.stringForKey("token"),
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
            self.uiService.showErrorAlertMessage(error.info)
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
    
    @objc private func fillTestData() {
        self.loginTextField.textField.text = "ios_test_task_andrey_krasivichev_test"
        self.passwordTextField.textField.text = "Xahpow-1cuwku-qopvec"
        self.applicantIdentifierTextField.textField.text = "5ea987670a975a052caea49b"
        self.continueButton.isEnabled = true
    }
}
