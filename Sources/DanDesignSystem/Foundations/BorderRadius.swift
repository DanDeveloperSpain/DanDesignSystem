//
//  BorderRadius.swift
//  
//
//  Created by Daniel Pérez Parreño on 14/5/22.
//

import UIKit

public enum Radius: CGFloat {
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

public enum Border: CGFloat {
    case small = 1
    case medium = 2
    case none = 0

    public var borderName: String {
        switch self {
        case .small:
            return "Small"
        case .medium:
            return "Medium"
        case .none:
            return "None"
        }
    }

}

public extension UIView {

    func boderRadius(radius: Radius, border: Border = .none, colorBorder: Bool = true){
        
        switch radius {
        case .small, .medium, .large:
            self.layer.cornerRadius = radius.rawValue
        case .full:
            let height = self.frame.height
            self.layer.cornerRadius = height/2
        }

        switch border {
        case .small:
            self.layer.borderWidth = 1
        case .medium:
            self.layer.borderWidth = 2
        case .none:
            self.layer.borderWidth = 0
        }

        if colorBorder {
            switch border {
            case .small:
                self.layer.borderColor = UIColor.dsGrayLight.cgColor
            case .medium:
                self.layer.borderColor = UIColor.dsBlack.cgColor
            case .none:
                break
            }
        }

    }

}
