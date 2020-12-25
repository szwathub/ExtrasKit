//
//  Copyright © 2020 ZhiweiSun. All rights reserved.
//
//  File name: UIView+Screenshot.swift
//  Author:    Zhiwei Sun @szwathub
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2020/12/25: Created by szwathub on 2020/12/25
//

import Foundation

extension ExtrasKitWrapper where Base: UIView {
    /// Take screenshot of view.
    ///
    /// - Parameters:
    ///     - opaque: A Boolean flag indicating whether the bitmap is opaque.
    /// - Returns: A screenshot image of view.
    ///
    public func screenshot(_ opaque: Bool) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(base.bounds.size, opaque, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }

        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        base.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()

        return image
    }
}
