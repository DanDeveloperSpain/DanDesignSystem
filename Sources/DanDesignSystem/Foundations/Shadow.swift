//
//  Shadow.swift
//  
//
//  Created by Daniel Pérez Parreño on 14/5/22.
//

import UIKit

public enum Shadow {
    case base
    case flat
    case small
    case medium
    case transparent
    case large

    public var shadowName: String {
        switch self {
        case .base:
            return "Base"
        case .flat:
            return "Flat"
        case .small:
            return "Small"
        case .medium:
            return "Medium"
        case .large:
            return "Large"
        case .transparent:
            return "Transparent"
        }
    }

}

public extension UIView {

    func shadow(shadow: Shadow, color : UIColor){

        switch shadow {
        case .base:
            self.layer.backgroundColor = color.cgColor
            self.layer.shadowOpacity = 0
            self.layer.shadowRadius = 0
        case .flat:
            self.layer.shadowOpacity = 0
            self.layer.shadowRadius = 0
            self.layer.borderColor = color.cgColor
            self.layer.borderWidth = 1
        case .small:
            self.layer.shadowOffset = CGSize(width: 0, height: 2)
            self.layer.shadowOpacity = 6
            self.layer.shadowRadius = 3
            self.layer.shadowColor = color.cgColor
        case .medium:
            self.layer.shadowOffset = CGSize(width: 0, height: 4)
            self.layer.shadowOpacity = 8
            self.layer.shadowRadius = 5
            self.layer.shadowColor = color.cgColor
        case .transparent:
            self.layer.backgroundColor = color.withAlphaComponent(0.95).cgColor
        case .large:
            self.layer.shadowOffset = CGSize(width: 0, height: 8)
            self.layer.shadowOpacity = 16
            self.layer.shadowRadius = 10
            self.layer.shadowColor = color.cgColor
        }

    }

}
