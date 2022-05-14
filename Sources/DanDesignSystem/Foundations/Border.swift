//
//  Border.swift
//  
//
//  Created by Daniel Pérez Parreño on 14/5/22.
//

import UIKit

public enum Border: CGFloat {
    case small = 4
    case medium = 8
    case large = 16
    case full = 0

    public var borderName: String {
        switch self {
        case .small:
            return "Small"
        case .medium:
            return "Medium"
        case .large:
            return "Large"
        case .full:
            return "Full"
        }
    }

}

public extension UIView {

    func boder(border: Border, bigBorder: Bool? = true, colorBorder: Bool? = true){

        switch border {
        case .small, .medium, .large:
            self.layer.cornerRadius = border.rawValue
        case .full:
            let height = self.frame.height
            self.layer.cornerRadius = height/2
        }

        if colorBorder! {
            if bigBorder! {
                self.layer.borderWidth = 2
                self.layer.borderColor = UIColor.dsBlack.cgColor
            } else {
                self.layer.borderWidth = 1
                self.layer.borderColor = UIColor.dsGrayLight.cgColor
            }
        }

    }

}
