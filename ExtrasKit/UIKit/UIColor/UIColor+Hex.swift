//
//  Copyright © 2020 ZhiweiSun. All rights reserved.
//
//  File name: UIColor+Hex.swift
//  Author:    Zhiwei Sun @szwathub
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2020/12/26: Created by szwathub on 2020/12/26
//

import Foundation

extension ExtrasKitWrapper where Base: UIColor {
    /// Initializers for creating colors
    public static func with(red: UInt8, green: UInt8, blue: UInt8, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }

    /// Initializers for creating colors
    public static func with(hex: UInt32, alpha: CGFloat = 1.0) -> UIColor {
        let red = UInt8((hex & 0xFF0000) >> 16)
        let green = UInt8((hex & 0x00FF00) >> 8)
        let blue = UInt8(hex & 0x0000FF)

        return self.with(red: red, green: green, blue: blue, alpha: alpha)
    }

    /// Initializers for creating colors
    public static func with(hexString: String) -> UIColor {
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")

        var red: CGFloat = 1.0
        var green: CGFloat = 1.0
        var blue: CGFloat = 1.0
        var alpha: CGFloat = 1.0

        func getColorComponnet(string: String, start: Int, length: Int) -> CGFloat {
            let startIndex = string.index(string.startIndex, offsetBy: start)
            let endIndex = string.index(string.startIndex, offsetBy: start + length)
            var rHex = String(string[startIndex..<endIndex])
            rHex = rHex.count == 2 ? rHex : rHex + rHex

            var component: UInt32 = 0
            Scanner(string: rHex).scanHexInt32(&component)

            return CGFloat(component) / 255.0
        }

        switch formatted.count {
        case 3: // #RGB
            red   = getColorComponnet(string: formatted, start: 0, length: 1)
            green = getColorComponnet(string: formatted, start: 1, length: 1)
            blue  = getColorComponnet(string: formatted, start: 2, length: 1)
            alpha = 1.0
        case 4: // #RGBA
            red   = getColorComponnet(string: formatted, start: 0, length: 1)
            green = getColorComponnet(string: formatted, start: 1, length: 1)
            blue  = getColorComponnet(string: formatted, start: 2, length: 1)
            alpha = getColorComponnet(string: formatted, start: 3, length: 1)
        case 6: // #RRGGBB
            red   = getColorComponnet(string: formatted, start: 0, length: 2)
            green = getColorComponnet(string: formatted, start: 2, length: 2)
            blue  = getColorComponnet(string: formatted, start: 4, length: 2)
            alpha = 1.0
        case 8: // #RRGGBBAA
            red   = getColorComponnet(string: formatted, start: 0, length: 2)
            green = getColorComponnet(string: formatted, start: 2, length: 2)
            blue  = getColorComponnet(string: formatted, start: 4, length: 2)
            alpha = getColorComponnet(string: formatted, start: 6, length: 2)
        default:
            #if DEBUG
            assert(false, "Color \(hexString) is invalid. It should be a hex value of the form #RBG, #RGBA, #RRGGBB, or #RRGGBBAA")
            #endif
        }

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    /// Gets the hexadecimal string of color.
    public var hexString: String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        let multiplier = CGFloat(255.999999)

        guard base.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }

        if alpha == 1.0 {
            return String(format: "%02lX%02lX%02lX",
                          Int(red * multiplier),
                          Int(green * multiplier),
                          Int(blue * multiplier))
        } else {
            return String(
                format: "%02lX%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier),
                Int(alpha * multiplier)
            )
        }
    }
}
