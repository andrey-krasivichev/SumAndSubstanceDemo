//
//  LoadingSupportButton.swift
//  SumAndSubstanceDemo
//
//  Created by Andrey Krasivichev on 05.05.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import UIKit

class LoadingSupportButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var loadingView: ThreeDotsLoadingView = {
        let view = ThreeDotsLoadingView()
        self.addSubview(view)
        return view
    }()
    
    func startLoadingAnimation() {
        self.isUserInteractionEnabled = false
        self.titleLabel?.alpha = 0.0
        self.loadingView.startAnimating()
    }
    
    func stopLoadingAnimation() {
        self.isUserInteractionEnabled = true
        self.titleLabel?.alpha = 1.0
        self.loadingView.stopAnimating()
    }
    
    override func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        super.setTitleColor(color, for: state)
        if state == UIControl.State.normal, let normalStateColor = color {
            self.loadingView.indicatorColor = normalStateColor
        }
    }
    
    private func setupConstraints() {
        self.loadingView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}

private class ThreeDotsLoadingView: UIView {
    
    private static let frameInterval = 1.0 / 30.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupConstraints()
        self.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var leftDotView: UIView = {
        let view = self.generateDotView()
        view.alpha = 0.99
        return view
    }()
    
    private var leftDotAnimationUp: Bool = true
    
    private lazy var midDotView: UIView = {
        let view = self.generateDotView()
        view.alpha = 0.66
        return view
    }()
    
    private var midDotAnimationUp: Bool = true
    
    private lazy var rightDotView: UIView = {
        let view = self.generateDotView()
        view.alpha = 0.33
        return view
    }()
    
    private var rightDotAnimationUp: Bool = true
    
    private let contentSize: CGSize = CGSize(width: 26.0, height: 6.0)
    private var animationTimer: Timer?
    
    override var intrinsicContentSize: CGSize {
        return self.contentSize
    }
    
    // MARK: Public
    func startAnimating() {
        self.isHidden = false
        if let timer = self.animationTimer, timer.isValid {
            return
        }
        
        self.animationTimer = Timer.scheduledTimer(timeInterval: ThreeDotsLoadingView.frameInterval, target: self,
                                                   selector: #selector(processAnimation), userInfo: nil, repeats: false)
    }
    
    func stopAnimating() {
        self.animationTimer?.invalidate()
        self.animationTimer = nil
        self.isHidden = true
    }
    
    var isAnimating: Bool {
        return self.animationTimer?.isValid ?? false
    }
    
    var indicatorColor: UIColor {
        get {
            return self.leftDotView.backgroundColor ?? UIColor.clear
        }
        set {
            self.leftDotView.backgroundColor = newValue
            self.midDotView.backgroundColor = newValue
            self.rightDotView.backgroundColor = newValue
        }
    }
    
    // MARK: Private
    private func setupConstraints() {
        self.midDotView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.height.equalTo(6.0)
        }
        
        self.leftDotView.snp.makeConstraints { (make) in
            make.right.equalTo(self.midDotView.snp.left).offset(-StyleSheet.Offsets.xs)
            make.width.height.equalTo(self.midDotView)
            make.centerY.equalTo(self.midDotView)
        }
        
        self.rightDotView.snp.makeConstraints { (make) in
            make.left.equalTo(self.midDotView.snp.right).offset(StyleSheet.Offsets.xs)
            make.width.height.equalTo(self.midDotView)
            make.centerY.equalTo(self)
        }
    }
    
    private func generateDotView() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 3.0
        view.clipsToBounds = true
        view.backgroundColor = StyleSheet.Colors.mainWhite
        self.addSubview(view)
        return view
    }
    
    @objc private func processAnimation() {
        let nextStepLeftDotAnimation = self.leftDotAnimationUp ? 1.0 : -1.0
        let alphaStepIncrement = 0.04
        self.leftDotView.alpha = self.leftDotView.alpha + CGFloat(alphaStepIncrement * nextStepLeftDotAnimation)
        self.leftDotAnimationUp = self.leftDotView.alpha >= 1.0 ? false : self.leftDotView.alpha <= 0.2 ? true : self.leftDotAnimationUp
        
        let nextStepMidDotAnimation = self.midDotAnimationUp ? 1.0 : -1.0
        self.midDotView.alpha = self.midDotView.alpha + CGFloat(alphaStepIncrement * nextStepMidDotAnimation)
        self.midDotAnimationUp = self.midDotView.alpha >= 1.0 ? false : self.midDotView.alpha <= 0.2 ? true : self.midDotAnimationUp
        
        let nextStepRightDotAnimation = self.rightDotAnimationUp ? 1.0 : -1.0
        self.rightDotView.alpha = self.rightDotView.alpha + CGFloat(alphaStepIncrement * nextStepRightDotAnimation)
        self.rightDotAnimationUp = self.rightDotView.alpha >= 1.0 ? false : self.rightDotView.alpha <= 0.2 ? true : self.rightDotAnimationUp
        
        self.animationTimer = Timer.scheduledTimer(timeInterval: ThreeDotsLoadingView.frameInterval, target: self,
                                                   selector: #selector(processAnimation), userInfo: nil, repeats: false)
    }
}
