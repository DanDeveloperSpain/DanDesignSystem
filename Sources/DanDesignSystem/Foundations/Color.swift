//
//  Color.swift
//  
//
//  Created by Daniel Pérez Parreño on 13/5/22.
//

import UIKit

public extension UIColor {
    
    /// Neutrals
    static let dsBlack = UIColor(hex: "#000000")!
    static let dsWhite = UIColor(hex: "#FFFFFF")!
    
    /// Primary
    static let dsPrimaryPure = UIColor(hex: "#FF6D00")!
    static let dsPrimaryDark = UIColor(hex: "#E65100")!
    static let dsPrimaryLight = UIColor(hex: "#FFAB40")!
    
    /// Secondary
    static let dsSecondaryPure = UIColor(hex: "#FFFF00")!
    static let dsSecondaryDark = UIColor(hex: "#FFD600")!
    static let dsSecondaryLight = UIColor(hex: "#FFFF8D")!
    
    ///Typography
    static let dsGrayPure = UIColor(hex: "#757575")!
    static let dsGrayDark = UIColor(hex: "#212121")!
    static let dsGrayLight = UIColor(hex: "#9E9E9E")!
    
    /// Error
    static let dsErrorPure = UIColor(hex: "#F44336")!
    static let dsErrorDark = UIColor(hex: "#B71C1C")!
    static let dsErrorLight = UIColor(hex: "#EF9A9A")!

    /// Waring
    static let dsWaringPure = UIColor(hex: "#FFEB3B")!
    static let dsWaringDark = UIColor(hex: "#FDD835")!
    static let dsWaringLight = UIColor(hex: "#FFF176")!

    /// Info
    static let dsInfoPure = UIColor(hex: "#00C853")!
    static let dsInfoDark = UIColor(hex: "#388E3C")!
    static let dsInfoLight = UIColor(hex: "#81C784")!
    
    /// Others
        /// Blue
    static let dsBluePure = UIColor(hex: "#2962FF")!
    static let dsBlueDark = UIColor(hex: "#0D47A1")!
    static let dsBlueLight = UIColor(hex: "#64B5F6")!
        /// Purple
    static let dsPurplePure = UIColor(hex: "#AA00FF")!
    static let dsPurpleDark = UIColor(hex: "#4A148C")!
    static let dsPurpleLight = UIColor(hex: "##CE93D8")!
    
    
    
    ///Initialization
    private convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    /// Hex Property
    var hex: String? {
        return toHex()
    }
    
    ///Util
    private func toHex(alpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        }
        return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
    }
}
