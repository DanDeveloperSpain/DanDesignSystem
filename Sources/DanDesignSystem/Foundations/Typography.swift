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
        case baskervilleRegular = "LibreBaskerville-Regular"
        case baskervilleItalic = "LibreBaskerville-Italic"
        case baskervilleBold = "LibreBaskerville-Bold"

        func toString() -> String {
            return self.rawValue
        }

        static func getRegular() -> String {
            return self.baskervilleRegular.rawValue
        }
        
        static func getBold() -> String {
            return self.baskervilleBold.rawValue
        }
        
        static func getItalic() -> String {
            return self.baskervilleItalic.rawValue
        }
    }
    
    public enum FontsWithSize {
        case regularMini
        case regularSmall
        case regularMedium
        case regularLarge
        case regularExtraLarge
        case regularSuper
        case italicMini
        case italicSmall
        case italicMedium
        case italicLarge
        case boldMini
        case boldSmall
        case boldMedium
        case boldLarge
        
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
                return UIFont(name: Typography.DanFonts.getRegular(), size: 24)
            case .regularSuper:
                return UIFont(name: Typography.DanFonts.getRegular(), size: 32)
            case .italicMini:
                return UIFont(name: Typography.DanFonts.getItalic(), size: 12)
            case .italicSmall:
                return UIFont(name: Typography.DanFonts.getItalic(), size: 14)
            case .italicMedium:
                return UIFont(name: Typography.DanFonts.getItalic(), size: 16)
            case .italicLarge:
                return UIFont(name: Typography.DanFonts.getItalic(), size: 18)
            case .boldMini:
                return UIFont(name: Typography.DanFonts.getBold(), size: 12)
            case .boldSmall:
                return UIFont(name: Typography.DanFonts.getBold(), size: 14)
            case .boldMedium:
                return UIFont(name: Typography.DanFonts.getBold(), size: 16)
            case .boldLarge:
                return UIFont(name: Typography.DanFonts.getBold(), size: 18)
            }
        }
    }

}

/// Configure Labels
public extension UILabel {
    
    func dsConfigure(with text: String? = nil, font: Typography.FontsWithSize, color: UIColor = .dsGrayPure) {
        if let text = text {
            self.text = text
        }

        if self.textAlignment != .center {
            self.textAlignment = .left
        }

        self.font = font.get()
        self.textColor = color
    }
    
}
