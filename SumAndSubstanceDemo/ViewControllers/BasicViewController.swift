//
//  ViewController.swift
//  SumAndSubstanceDemo
//
//  Created by Andrey Krasivichev on 05.05.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import UIKit
import SnapKit

class BasicViewController: UIViewController, ServicesProviderUsage, ContentViewContainer, UIGestureRecognizerDelegate {

    unowned var servicesProvider: ServicesProvider
    private(set) var isInitialAppearance: Bool = true
    lazy private var keyboardChangesHandler: KeyboardChangesHandler = {
        return KeyboardChangesHandler()
    }()
    private(set) var followsKeyboardChanges: Bool = false
    
    lazy var contentView: UIView = {
        let contentView = UIView(frame: self.view.bounds)
        self.view.addSubview(contentView)
        return contentView
    }()
    private var contentBottomConstraint: Constraint?
    
    init(servicesProvider: ServicesProvider) {
        self.servicesProvider = servicesProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.isInitialAppearance = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.isInitialAppearance, self.followsKeyboardChanges {
            self.registerForKeyboardEvents()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            self.contentBottomConstraint = make.bottom.equalTo(self.view).constraint
        }
        self.view.backgroundColor = UIColor.white
    }

    func setupConstraints() {
        // subclass hook
    }
    
    final func setupKeyboardHandler() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        tapRecognizer.delaysTouchesBegan = false
        tapRecognizer.delaysTouchesEnded = false
        tapRecognizer.cancelsTouchesInView = false
        tapRecognizer.delegate = self
        self.contentView.addGestureRecognizer(tapRecognizer)
        self.followsKeyboardChanges = true
    }
    
    private func registerForKeyboardEvents() {
        self.keyboardChangesHandler.keyboardFrameChangeBlock = { [weak self] (from: CGRect, to: CGRect, animateInterval: TimeInterval) -> () in
            guard let self = self, let constraint = self.contentBottomConstraint else {
                return
            }
            constraint.update(inset: to.height)
            UIView.animate(withDuration: animateInterval, animations: {
                self.view.layoutIfNeeded()
            })
        }

        self.keyboardChangesHandler.keyboardWillShowBlock = { [weak self] (from: CGRect, to: CGRect, animateInterval: TimeInterval) -> () in
            /*
            guard let self = self else {
                return
            }

            let firstResponder = UIResponder.currentFirst() as? UIView
            if let activeTextInput = firstResponder, activeTextInput is UITextInput {
                let scrollView = self.view.allSubviews(uiView: self.view).first(where: { $0 is UIScrollView && activeTextInput.superviews().contains($0) }) as? UIScrollView
                if let scrollView = scrollView {
                    if let textView = activeTextInput as? UITextView {
                        scrollView.scrollToView(textView: textView, animated: true)
                    } else {
                        scrollView.scrollToView(view: activeTextInput, animated: true)
                    }
                }
            }*/
        }

        self.keyboardChangesHandler.beginObserving()
    }
    
    @objc func closeKeyboard() {
        self.contentView.endEditing(true)
    }
    
    // MARK: <UIGestureRecognizerDelegate>
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard gestureRecognizer is UITapGestureRecognizer else {
            return true
        }
        guard let view = touch.view else {
            return false
        }
        let isControl = view is UIControl
        return !isControl
    }
}

