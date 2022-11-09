//
//  Copyright © 2021 ZhiweiSun. All rights reserved.
//
//  File name: UIColor+ExtrasKit.swift
//  Author:    Zhiwei Sun @szwathub
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2021/12/1: Created by szwathub on 2021/12/1
//

#if os(iOS) || os(tvOS)

import UIKit

extension UIColor {

    /// Initializers for creating colors
    public convenience init?(hex: UInt32, alpha: CGFloat = 1.0) {
        let red = UInt8((hex & 0xFF0000) >> 16)
        let green = UInt8((hex & 0x00FF00) >> 8)
        let blue = UInt8(hex & 0x0000FF)

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
}

extension UIColor: ExtrasKitCompatible { }

extension ExtrasKitWrapper where Base: UIColor {

    /// Gets the hexadecimal string of color.
    public var hexString: String? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0
        var alpha: CGFloat = 0

        let multiplier = CGFloat(255.999999)
        guard base.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }

        if let colors = base.cgColor.components, colors.count == 4 {
            red = colors[0]
            green = colors[1]
            blue = colors[2]
            alpha = colors[3]
        }

        if alpha == 1.0 {
            return String(format: "#%02lX%02lX%02lX",
                          Int(red * multiplier),
                          Int(green * multiplier),
                          Int(blue * multiplier))
        } else {
            return String(
                format: "#%02lX%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier),
                Int(alpha * multiplier)
            )
        }
    }
}

#endif
