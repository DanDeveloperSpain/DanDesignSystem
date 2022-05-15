//
//  File.swift
//  
//
//  Created by Daniel Pérez Parreño on 15/5/22.
//

import UIKit

public func DSImage(named name: DSGetImage) -> UIImage? {
    UIImage(named: name.rawValue, in: Bundle.module, compatibleWith: nil)
}

public enum DSGetImage: String  {

    /// Icons
    case icon_cross
    case icon_info

}
