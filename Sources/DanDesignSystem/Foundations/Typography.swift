//
//  Typography.swift
//  
//
//  Created by Daniel Pérez Parreño on 13/5/22.
//

import UIKit


/// Register Fonts
public extension UIFont {
    
    static func registerFonts() {
        
        let fonts = Bundle.module.urls(forResourcesWithExtension: "ttf", subdirectory: nil)
        
        fonts?.forEach({ url in
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        })
    }
    
}

/// Typography
public final class Typography {

    public enum DanFonts: String {
        case oleaRegular = "OleoScriptSwashCaps-Regular"

        func toString() -> String {
            return self.rawValue
        }

        static func getRegular() -> String {
            self.oleaRegular.rawValue
        }
    }
    
    public enum FontsWithSize {
        case regularMini
        case regularSmall
        case regularMedium
        case regularLarge
        case regularExtraLarge
        case regularSuper
        
        public func get() -> UIFont? {
            switch self {
            case .regularMini:
                return UIFont(name: Typography.DanFonts.getRegular(), size: 12)
            case .regularSmall:
                return UIFont(name: Typography.DanFonts.getRegular(), size: 14)
            case .regularMedium:
                return UIFont(name: Typography.DanFonts.getRegular(), size: 16)
            case .regularLarge:
                return UIFont(name: Typography.DanFonts.getRegular(), size: 18)
            case .regularExtraLarge:
                print("___")
                return UIFont(name: Typography.DanFonts.getRegular(), size: 24)
            case .regularSuper:
                return UIFont(name: Typography.DanFonts.getRegular(), size: 32)
            }
        }
    }

}

/// Configure Labels
public extension UILabel {
    
    func dsConfigure(with text: String? = nil, font: Typography.FontsWithSize, color: UIColor = UIColor.gray) {
        self.dsBaseConfigure(with: text, font: font, color: color)
    }
    func dsBaseConfigure(with text: String?, font: Typography.FontsWithSize, color: UIColor = UIColor.gray) {
        self.text = text ?? ""
        if self.textAlignment != .center {
            self.textAlignment = .left
        }

        self.font = font.get()
        self.textColor = color
    }
    
}
