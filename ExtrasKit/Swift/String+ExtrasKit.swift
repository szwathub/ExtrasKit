//
//  Copyright © 2022 ZhiweiSun. All rights reserved.
//
//  File name: String+ExtrasKit.swift
//  Author:    Zhiwei Sun @szwathub
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2022/11/9: Created by szwathub on 2022/11/9
//

import Foundation
import UIKit

extension String: ExtrasKitCompatibleValue { }

extension ExtrasKitWrapper where Base == String {

    public var color: UIColor {
        var formatted = base.trimmingCharacters(in: .whitespacesAndNewlines)
        formatted = formatted.replacingOccurrences(of: "0x", with: "")
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
                "Color \(base) is invalid.
                It should be a hex value of the form #RBG, #RGBA, #RRGGBB, or #RRGGBBAA
                """
                assert(false, info)
#endif
                return .clear
        }

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
