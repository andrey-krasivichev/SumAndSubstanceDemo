//
//  Created by Andrey Krasivichev on 02.04.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//


import UIKit

extension UIView {
    @discardableResult
    func supplyWithButton(target: AnyObject, action: Selector, controlsAlpha: Bool = false) -> UIButton {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        button.frame = self.bounds
        self.addSubview(button)
        button.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        if controlsAlpha {
            button.addTarget(self, action: #selector(setHalfVisible), for: UIControl.Event.touchDown)
            button.addTarget(self, action: #selector(setHalfVisible), for: UIControl.Event.touchDragEnter)
            button.addTarget(self, action: #selector(setFullyVisible), for: UIControl.Event.touchDragExit)
            button.addTarget(self, action: #selector(setFullyVisible), for: UIControl.Event.touchUpInside)
            button.addTarget(self, action: #selector(setFullyVisible), for: UIControl.Event.touchCancel)
        }
        return button
    }
    
    @objc fileprivate func setHalfVisible() {
        self.alpha = 0.5
    }
    
    @objc fileprivate func setFullyVisible() {
        self.alpha = 1.0
    }
    
    func hideAnimated() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0.0
        }
    }
    
    func showAnimated() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1.0
        }
    }
}

extension UIButton {
    func applyHalfVisibilityOnStateChanged() {
        self.addTarget(self, action: #selector(setHalfVisible), for: UIControl.Event.touchDown)
        self.addTarget(self, action: #selector(setHalfVisible), for: UIControl.Event.touchDragEnter)
        self.addTarget(self, action: #selector(setFullyVisible), for: UIControl.Event.touchDragExit)
        self.addTarget(self, action: #selector(setFullyVisible), for: UIControl.Event.touchUpInside)
        self.addTarget(self, action: #selector(setFullyVisible), for: UIControl.Event.touchCancel)
    }
}

extension UIView {
    func makeImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, self.isOpaque, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        self.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    static func containerViewWithSubviews(_ subviews: [UIView]) -> UIView {
        let view = UIView()
        for subview in subviews {
            view.addSubview(subview)
        }
        return view
    }
}

extension UIStackView {
    func removeArrangedSubviews() {
        for subview in self.arrangedSubviews {
            self.removeArrangedSubview(subview)
        }
    }
}

extension UIScrollView {
    func setContentOffsetToTopInset(animated: Bool) {
        self.setContentOffset(CGPoint(x: 0.0, y: -self.contentInset.top), animated: animated)
        self.delegate?.scrollViewDidScroll?(self)
    }

    func scrollToBottom(animated: Bool) {
        let scrollOffset = max(0, self.contentSize.height - self.bounds.size.height)
        self.setContentOffset(CGPoint(x: 0, y: scrollOffset), animated: animated)
    }
}

extension UIScrollView {

    func scrollToView(view: UIView, animated: Bool) {
        let viewFrame = view.convert(view.bounds, to: self)
        let viewOverlappedHeight = viewFrame.origin.y + viewFrame.height - self.bounds.height
        let scrollOffset = max(0, viewOverlappedHeight)
        self.setContentOffset(CGPoint(x: 0, y: scrollOffset), animated: animated)
    }

    func scrollToView(textView: UITextView, animated: Bool) {
        let viewFrame = textView.convert(textView.bounds, to: self)
        let caretRect = textView.caret ?? CGRect(x: 0, y: viewFrame.height, width: 0, height: 0)
        let bottomOffset: CGFloat = 34
        let viewOverlappedHeight = viewFrame.origin.y + caretRect.origin.y + caretRect.height - self.bounds.height + bottomOffset
        let scrollOffset = max(0, viewOverlappedHeight)
        self.setContentOffset(CGPoint(x: 0, y: scrollOffset), animated: animated)
    }

    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }

    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }

}

extension UITextView {
    var caret: CGRect? {
        guard let selectedTextRange = self.selectedTextRange else {
            return nil
        }
        let rect = self.caretRect(for: selectedTextRange.end)

        if !rect.isNull, !rect.isInfinite {
            return self.caretRect(for: selectedTextRange.end)
        }
        return nil
    }
}

extension UITableView {
    func doesShowLastCellOfHeight(_ height: CGFloat) -> Bool {
        let contentHeight = self.contentSize.height
        let frameHeight = self.frame.height
        if contentHeight < frameHeight {
            return true
        }
        let currentOffset = self.contentOffset.y
        return contentHeight - frameHeight - currentOffset < height
    }
}

extension Array where Element: StringProtocol  {
    func lowercased() -> [String] {
        var result: [String] = []
        for item in self {
            result.append(item.lowercased())
        }
        return result
    }
}

extension String {
    func isEqualToAddress(_ address: String) -> Bool {
        return self.caseInsensitiveCompare(address) == ComparisonResult.orderedSame
    }
}

extension Date {
    
    func years(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.year], from: sinceDate, to: self).year
    }
    
    func months(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.month], from: sinceDate, to: self).month
    }
    
    func days(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.day], from: sinceDate, to: self).day
    }
    
    func hours(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.hour], from: sinceDate, to: self).hour
    }
    
    func minutes(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.minute], from: sinceDate, to: self).minute
    }
    
    func seconds(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.second], from: sinceDate, to: self).second
    }
}

extension Set {
    mutating func add(contentsOf array: [Element]) {
        array.forEach {
            self.update(with: $0)
        }
    }
}

extension Double {
    var isZero: Bool {
        return !(self > 0.0 || self < 0.0)
    }
}

extension Double {
    var asDecimal: Decimal {
        return Decimal(self)
    }
}

extension Float {
    var isZero: Bool {
        return !(self > 0.0 || self < 0.0)
    }

    func normalized(min: Float, max: Float) -> Float {
        return (self - min) / (max - min)
    }
}

extension Bool {
    static func |=(lhs: inout Bool, rhs: Bool) {
        lhs = lhs || rhs
    }

    static func &=(lhs: inout Bool, rhs: Bool) {
        lhs = lhs && rhs
    }
}

extension TimeInterval {
    static var minute = 60.0
    static var hour = TimeInterval.minute * 60.0
    static var day = TimeInterval.hour * 24.0
    static var week = TimeInterval.day * 7.0
    static var month = TimeInterval.day * 30.0
    static var year = TimeInterval.month * 12.0
}

extension Dictionary {
    func queryString() -> String {
        var result = ""
        let keys = Array(self.keys)
        for index in 0 ..< keys.count {
            let shouldAddAmpersand = index < keys.count - 1
            let key = keys[index]
            guard let keyString = key as? String,
            let value = self[key] else {
                continue
            }
            if let arrayValue = value as? [String] {
                result.append("\(keyString)=\(arrayValue.queryString())")
            } else {
                result.append("\(keyString)=\(value)")
            }
            result.append(shouldAddAmpersand ? "&" : "")
        }
        return result
    }
}

extension Dictionary where Key == String {
    func intForKey(_ key: String) -> Int? {
        return self[key] as? Int
    }
    
    func boolForKey(_ key: String) -> Bool? {
        return self[key] as? Bool
    }
    
    func doubleForKey(_ key: String) -> Double? {
        if let value = self[key] as? Double {
            return value
        }
        if let valueString = self[key] as? String {
            return Double(valueString)
        }
        return nil
    }
    
    func arrayForKey(_ key: String) -> [Any]? {
        return self[key] as? [Any]
    }
    
    func dictionaryForKey(_ key: String) -> [String : Any]? {
        return self[key] as? [String : Any]
    }
    
    func stringForKey(_ key: String) -> String? {
        return self[key] as? String
    }
    
    func unsignedInt64ForKey(_ key: String) -> UInt64? {
        if let value = self[key] as? UInt64 {
            return value
        }
        if let valueString = self.stringForKey(key) {
            return UInt64(valueString)
        }
        return nil
    }
}

extension Array where Element : StringProtocol {
    func queryString() -> String {
        let result = self.joined(separator: ",")
        return result
    }
}

extension String {
    func convertDecimalToHex() -> String {
        guard let decimal = UInt64(self) else {
            return self
        }
        return String(format: "0x%llX", decimal)
    }
}

extension String {
    func encodeToBase64() -> String? {
        guard let data = self.data(using: Encoding.utf8) else {
            return nil
        }
        return data.base64EncodedString(options: Data.Base64EncodingOptions.init(rawValue: 0))
    }
    
    func decodeFromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(bytes: data, encoding: Encoding.utf8)
    }
}

extension Data {
    var hexDescription: String {
        return reduce("") {$0 + String(format: "%02x", $1)}
    }
}

typealias VoidBlock = () -> Void

func RedispatchToMainThread(_ block: @escaping VoidBlock) {
    if Thread.current.isMainThread {
        block()
        return
    }
    DispatchQueue.main.async(execute: block)
}

#if DEBUG
class Utils {
    static func benchmark(title: String = "", codeBlock: @escaping ()->()) {
        let startTime = CFAbsoluteTimeGetCurrent()
        codeBlock()
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        print(">>> Time elapsed for \(title): \(timeElapsed) s.")
    }
    
    static func printTimestamp(message: String = "") {
        print("\(message) \(Date().timeIntervalSince1970)")
    }
}
#endif
