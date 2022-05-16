//
//  File.swift
//  
//
//  Created by Daniel Pérez Parreño on 15/5/22.
//

import UIKit

/// Function to get an image hosted on the DS. It can only be established if it is registered so as not to have errors
/// - Parameter name: image name
/// - Returns: an image hosted on the DesignSystem
public func DSImage(named name: DSGetImage) -> UIImage? {
    UIImage(named: name.rawValue, in: Bundle.module, compatibleWith: nil)
}

public enum DSGetImage: String  {

    /// Icons
    case icon_cross
    case icon_info
    case icon_backButton
    case icon_mail

    /// Images
    case marverComics

}
