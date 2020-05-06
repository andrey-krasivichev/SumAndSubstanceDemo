//
//  KeyboardChangesHandler.swift
//  SumAndSubstanceDemo
//
//  Created by Andrey Krasivichev on 05.05.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import UIKit

class KeyboardChangesHandler {
    
    var keyboardFrame: CGRect
    var keyboardFrameChangeBlock: (_ fromRect: CGRect, _ toRect: CGRect, _ animationDuration: TimeInterval) -> Void = {_,_,_ in }
    var keyboardWillShowBlock: (_ fromRect: CGRect, _ toRect: CGRect, _ animationDuration: TimeInterval) -> Void = {_,_,_ in }
    
    init() {
        self.keyboardFrame = CGRect.zero

    }

    func beginObserving() {
        let notificationsCenter = NotificationCenter.default
        notificationsCenter.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationsCenter.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationsCenter.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        let keyboardBeginFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue ?? CGRect.zero
        let keyboardEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? CGRect.zero
        guard !keyboardBeginFrame.equalTo(keyboardEndFrame) else {
            return
        }
        let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? Double(0)
        self.keyboardWillShowBlock(keyboardBeginFrame, keyboardEndFrame, animationDuration)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else {
            return
        }
        let keyboardBeginFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue ?? CGRect.zero
        let keyboardEndFrame = CGRect.zero
        let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? Double(0)
        self.keyboardFrameChangeBlock(keyboardBeginFrame, keyboardEndFrame, animationDuration)
        self.keyboardFrame = keyboardEndFrame
    }
    
    @objc func keyboardWillChangeFrame(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        let keyboardBeginFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue ?? CGRect.zero
        let keyboardEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? CGRect.zero
        guard !keyboardBeginFrame.equalTo(keyboardEndFrame) else {
            return
        }
        let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? Double(0)
        self.keyboardFrameChangeBlock(keyboardBeginFrame, keyboardEndFrame, animationDuration)
        self.keyboardFrame = keyboardEndFrame
    }
}
