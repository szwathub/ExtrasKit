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

extension ExtrasKitWrapper where Base == String {

    /// Validates if a given string is a valid email address.
    ///
    /// - Returns: Return `true` if string is a valid email address, `false` otherwise.
    public func isValidEmail() -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)

        return predicate.evaluate(with: base)
    }
}

extension ExtrasKitWrapper where Base == String {

    /// Obtains the actual name of the executable file that runs the application.
    public static var appName: String? {
        guard let info = Bundle.main.infoDictionary?["CFBundleName"] as? String else {
            return nil
        }

        return info
    }

    /// Obtains the name of the application as it appears on the user's device. This name is what the user sees
    /// on the home screen and in the App Store
    public static var appDisplayName: String? {
        guard let info = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String else {
            return nil
        }

        return info
    }

    /// Obtains the short version of the application, also known as the "marketing version"
    /// The version number usually consists of three numbers, such as 1.0.1, where the first number
    /// represents the major version, the second number represents the minor version, and the third
    /// number represents the revision version. The value of this key is a string data type.
    public static var appVersion: String? {
        guard let info = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return nil
        }

        return info
    }

    /// Obtains the build version number of the application.
    public static var appBuildVersion: String? {
        guard let info = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else {
            return nil
        }

        return info
    }
}
