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

    /// Initializers for creating colors
    public convenience init?(hexString: String) {
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")

        var red = 1.0, green = 1.0, blue = 1.0, alpha = 1.0

        func getColorComponnet(string: String, start: Int, length: Int) -> CGFloat {
            let startIndex = string.index(string.startIndex, offsetBy: start)
            let endIndex = string.index(string.startIndex, offsetBy: start + length)
            var rHex = String(string[startIndex..<endIndex])
            rHex = rHex.count == 2 ? rHex : rHex + rHex

            var component: UInt64 = 0
            Scanner(string: rHex).scanHexInt64(&component)

            return CGFloat(component) / 255.0
        }

        switch formatted.count {
            case 4: // #RGBA
                alpha = getColorComponnet(string: formatted, start: 3, length: 1)
                fallthrough
            case 3: // #RGB
                red   = getColorComponnet(string: formatted, start: 0, length: 1)
                green = getColorComponnet(string: formatted, start: 1, length: 1)
                blue  = getColorComponnet(string: formatted, start: 2, length: 1)
            case 8: // #RRGGBBAA
                alpha = getColorComponnet(string: formatted, start: 6, length: 2)
                fallthrough
            case 6: // #RRGGBB
                red   = getColorComponnet(string: formatted, start: 0, length: 2)
                green = getColorComponnet(string: formatted, start: 2, length: 2)
                blue  = getColorComponnet(string: formatted, start: 4, length: 2)
            default:
#if DEBUG
                let info = """
                "Color \(hexString) is invalid.
                It should be a hex value of the form #RBG, #RGBA, #RRGGBB, or #RRGGBBAA
                """
                assert(false, info)
#endif
        }

        self.init(red: red, green: green, blue: blue, alpha: alpha)
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
