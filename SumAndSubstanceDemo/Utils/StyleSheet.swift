//
//  StyleSheet.swift
//  SumAndSubstanceDemo
//
//  Created by Andrey Krasivichev on 05.05.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import UIKit

struct StyleSheet {
    struct Fonts {}
    struct Colors {}
    struct Offsets {}
}

fileprivate extension UIFont {
    private static let prefersSystemFont = !UIDevice.isSystemVersionLowerThan(13.0)
    
    enum Font: String {
        case SFUIText = "SFUIText"
        case SFUIDisplay = "SFUIDisplay"
    }
    
    private static func name(of weight: UIFont.Weight) -> String? {
        switch weight {
        case .ultraLight: return "UltraLight"
        case .thin: return "Thin"
        case .light: return "Light"
        case .regular: return nil
        case .medium: return "Medium"
        case .semibold: return "Semibold"
        case .bold: return "Bold"
        case .heavy: return "Heavy"
        case .black: return "Black"
        default: return nil
        }
    }
    
    convenience init?(font: Font, weight: UIFont.Weight, size: CGFloat) {
        var fontName = ".\(font.rawValue)"
        if let weightName = UIFont.name(of: weight) {
            fontName += "-\(weightName)"
        }
        
        self.init(name: fontName, size: size)
    }
    
    static func appFont(_ font: Font, weight: UIFont.Weight, size: CGFloat) -> UIFont {
        if self.prefersSystemFont {
            return self.systemFont(ofSize: size, weight: weight)
        }
        return UIFont(font: font, weight: weight, size: size) ?? self.systemFont(ofSize: size, weight: weight)
    }
}

extension StyleSheet.Fonts {
    static let semibold38: UIFont = UIFont.appFont(.SFUIDisplay, weight: .semibold, size: 38) // UIFont(name: "SFProDisplay-Semibold", size: 38)
    static let medium38: UIFont = UIFont.appFont(.SFUIDisplay, weight: .medium, size: 38)    // UIFont(name: "SFProDisplay-Medium", size: 38)
    static let bold34: UIFont = UIFont.appFont(.SFUIDisplay, weight: .bold, size: 34)      // UIFont(name: "SFProDisplay-Bold", size: 34)
    static let bold27: UIFont = UIFont.appFont(.SFUIDisplay, weight: .bold, size: 27)      // UIFont(name: "SFProDisplay-Bold", size: 34)
    static let bold22: UIFont = UIFont.appFont(.SFUIDisplay, weight: .bold, size: 22)      // UIFont(name: "SFProDisplay-Bold", size: 22)
    static let bold12: UIFont = UIFont.appFont(.SFUIDisplay, weight: .bold, size: 12)
    static let semibold17: UIFont = UIFont.appFont(.SFUIText, weight: .semibold, size: 17)     // UIFont(name: "SFProText-Semibold", size: 17)
    static let regular17: UIFont = UIFont.appFont(.SFUIText, weight: .regular, size: 17)      // UIFont(name: "SFProText-Regular", size: 17)
    static let semibold15: UIFont = UIFont.appFont(.SFUIText, weight: .semibold, size: 15)     // UIFont(name: "SFProText-Semibold", size: 15)
    static let regular15: UIFont = UIFont.appFont(.SFUIText, weight: .regular, size: 15)      // UIFont(name: "SFProText-Regular", size: 15)
    static let medium15: UIFont = UIFont.appFont(.SFUIText, weight: .medium, size: 15)       // UIFont(name: "SFProText-Medium", size: 15)
    static let medium13: UIFont = UIFont.appFont(.SFUIText, weight: .medium, size: 13)       // UIFont(name: "SFProText-Medium", size: 13)
    static let regular12: UIFont = UIFont.appFont(.SFUIText, weight: .regular, size: 12)      // UIFont(name: "SFProText-Regular", size: 12)
    static let medium10: UIFont = UIFont.appFont(.SFUIText, weight: .medium, size: 10)       // UIFont(name: "SFProText-Medium", size: 10)
}

extension StyleSheet.Colors {
    
    /* Main Blue */
    static let mainBlue: UIColor = UIColor(hex: 0x003DC6)
    static let mainBlue60: UIColor = StyleSheet.Colors.mainBlue.withAlphaComponent(0.6)
    static let mainBlue50: UIColor = StyleSheet.Colors.mainBlue.withAlphaComponent(0.5)
    static let mainBlue40: UIColor = StyleSheet.Colors.mainBlue.withAlphaComponent(0.4)
    static let mainBlue30: UIColor = StyleSheet.Colors.mainBlue.withAlphaComponent(0.3)
    static let mainBlue20: UIColor = StyleSheet.Colors.mainBlue.withAlphaComponent(0.2)
    static let mainBlue10: UIColor = StyleSheet.Colors.mainBlue.withAlphaComponent(0.1)
    static let mainBlue5: UIColor = StyleSheet.Colors.mainBlue.withAlphaComponent(0.05)
    
    /* Main Black */
    static let mainBlack: UIColor = UIColor(hex: 0x081E39)
    static let mainBlack60: UIColor = StyleSheet.Colors.mainBlack.withAlphaComponent(0.6)
    static let mainBlack50: UIColor = StyleSheet.Colors.mainBlack.withAlphaComponent(0.5)
    static let mainBlack40: UIColor = StyleSheet.Colors.mainBlack.withAlphaComponent(0.4)
    static let mainBlack30: UIColor = StyleSheet.Colors.mainBlack.withAlphaComponent(0.3)
    static let mainBlack20: UIColor = StyleSheet.Colors.mainBlack.withAlphaComponent(0.2)
    static let mainBlack10: UIColor = StyleSheet.Colors.mainBlack.withAlphaComponent(0.1)
    static let mainBlack5: UIColor = StyleSheet.Colors.mainBlack.withAlphaComponent(0.05)
    
    /* Main Red */
    static let mainRed: UIColor = UIColor(hex: 0xDC3632)
    static let mainRed60: UIColor = StyleSheet.Colors.mainRed.withAlphaComponent(0.6)
    static let mainRed50: UIColor = StyleSheet.Colors.mainRed.withAlphaComponent(0.5)
    static let mainRed40: UIColor = StyleSheet.Colors.mainRed.withAlphaComponent(0.4)
    static let mainRed30: UIColor = StyleSheet.Colors.mainRed.withAlphaComponent(0.3)
    static let mainRed20: UIColor = StyleSheet.Colors.mainRed.withAlphaComponent(0.2)
    static let mainRed10: UIColor = StyleSheet.Colors.mainRed.withAlphaComponent(0.1)
    
    /* Main White */
    static let mainWhite: UIColor = UIColor.white
    static let mainWhite70: UIColor = StyleSheet.Colors.mainWhite.withAlphaComponent(0.7)
    static let mainWhite60: UIColor = StyleSheet.Colors.mainWhite.withAlphaComponent(0.6)
    static let mainWhite50: UIColor = StyleSheet.Colors.mainWhite.withAlphaComponent(0.5)
    static let mainWhite40: UIColor = StyleSheet.Colors.mainWhite.withAlphaComponent(0.4)
    static let mainWhite30: UIColor = StyleSheet.Colors.mainWhite.withAlphaComponent(0.3)
    static let mainWhite20: UIColor = StyleSheet.Colors.mainWhite.withAlphaComponent(0.2)
    static let mainWhite10: UIColor = StyleSheet.Colors.mainWhite.withAlphaComponent(0.1)

    /* Main Green */
    static let mainGreen: UIColor = UIColor(hex: 0x5AC6A9)
    static let mainGreen20: UIColor = StyleSheet.Colors.mainGreen.withAlphaComponent(0.2)
    
    static let positiveTrendColor: UIColor = UIColor(hex: 0x13D8A8)
    static let negativeTrendColor: UIColor = UIColor(hex: 0xFD6580)
    
}

extension StyleSheet.Offsets {
    /// 1
    static let xxxs: CGFloat = 1.0
    /// 2
    static let xxs: CGFloat = 2.0
    /// 4
    static let xs: CGFloat = 4.0
    /// 8
    static let s: CGFloat = 8.0
    /// 12
    static let m: CGFloat = 12.0
    /// 16
    static let l: CGFloat = 16.0
    /// 24
    static let xl: CGFloat = 24.0
    /// 32
    static let xxl: CGFloat = 32.0
    /// 36
    static let xxxl: CGFloat = 36.0
}
