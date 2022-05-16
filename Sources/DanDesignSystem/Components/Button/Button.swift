//
//  File.swift
//  
//
//  Created by Daniel Pérez Parreño on 14/5/22.
//

import UIKit

public enum TypeButton {
    case primary
    case secondary

    public var name: String {
        return String(describing: self)
    }

}

public enum StateButton {
    case enabled
    case disabled
    
    public var name: String {
        return String(describing: self)
    }

}

public extension UIButton {

    /// Configure styles buttons
    /// - Parameters:
    ///   - text: text of the button.
    ///   - image: image for button.
    ///   - style: button style.
    ///   - state: button state.
    ///   - width: width button constraint.
    func dsConfigure(text: String? = nil, image: UIImage? = nil, style: TypeButton? = .primary, state: StateButton? = .enabled, width: CGFloat = 100) {

        /// text
        if let text = text {
            self.setImage(nil, for: .normal)
            self.setTitle(text, for: .normal)
            self.titleLabel?.font = Typography.FontsWithSize.boldSmall.get()
        } else if let image = image {
            self.setTitle("", for: .normal)
            image.withRenderingMode(.alwaysTemplate)
            self.setImage(image, for: .normal)
            tintColor = .dsWhite
        }

        /// size
        self.frame = CGRect(x: 0, y: 0, width: width, height: 40)

        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: width),
            self.heightAnchor.constraint(equalToConstant: 40)
        ])

        /// border
        self.boderRadius(radius: .full)

        switch style {
        case .primary:
            self.setTitleColor(.dsWhite, for: .normal)
            
            switch state {
            case .enabled:
                self.backgroundColor = .dsBluePure
                self.shadow(shadow: .small, color: .dsBluePure)
                self.isUserInteractionEnabled = true
            case .disabled:
                self.backgroundColor = .dsPrimaryLight
                self.shadow(shadow: .small, color: .dsBlueLight)
                self.isUserInteractionEnabled = false
            default:
                break
            }

        case .secondary:
            self.shadow(shadow: .small, color: .dsGrayLight)

            switch state {
            case .enabled:
                self.setTitleColor(.dsBlack, for: .normal)
                self.backgroundColor = .dsWhite
                tintColor = .dsBlack
                self.isUserInteractionEnabled = true
            case .disabled:
                self.backgroundColor = .dsGrayLight
                self.setTitleColor(.dsWhite, for: .normal)
                self.isUserInteractionEnabled = false
            default:
                break
            }

        default:
            break
        }

    }

}
