//
//  Copyright © 2021 ZhiweiSun. All rights reserved.
//
//  File name: UIView+ExtrasKit.swift
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

extension UIView {

    /// Take screenshot of view.
    ///
    /// - Parameter opaque: A Boolean flag indicating whether the bitmap is opaque.
    /// - Returns: A screenshot image of view.
    public func screenshot(_ opaque: Bool) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, opaque, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }

        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()

        return image
    }
}

#endif
