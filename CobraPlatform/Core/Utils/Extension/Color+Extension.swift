//
//  Color+Extension.swift
//  CobraPlatform
//
//  Created by mac on 2024/7/4.
//

import Foundation
import UIKit


extension UIColor {
    
    convenience init(colorHex hex: UInt) {
        self.init(red: CGFloat((hex & 0xFF0000) >> 16) / 255,
                  green: CGFloat((hex & 0x00FF00) >> 8) / 255,
                  blue: CGFloat(hex & 0x0000FF) / 255, alpha: 1)
    }
}

extension UIColor {
    
    static let ThemeColor: UIColor = UIColor.black
}
