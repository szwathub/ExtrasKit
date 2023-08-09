//
//  Copyright © 2023 ZhiweiSun. All rights reserved.
//
//  File name: UIScrollView+ExtrasKit.swift
//  Author:    Zhiwei Sun @szwathub
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2023/2/27: Created by szwathub on 2023/2/27
//

import UIKit

extension UIScrollView: ExtrasKitCompatible { }

extension ExtrasKitWrapper where Base: UIScrollView {

    /// Constants that indicate how to scroll to the visible portion of the scroll view.
    public enum ScrollPosition {

        /// Scroll so that the scroll view is positioned at the top.
        case top

        /// Scroll so that the scroll view is positioned at the bottom.
        case bottom

        /// Scroll so that the scroll view is positioned at the left.
        case left

        /// Scroll so that the scroll view is positioned at the right.
        case right
    }

    /// Scrolls the scroll view contents until the specified position is visible.
    ///
    /// - Parameters:
    ///   - direction: An option that specifies where the item should be positioned when
    ///   scrolling finishes.
    ///   - animated: Specify `true` to animate the transition at a constant velocity to the new
    ///   position, `false` to make the transition immediate.
    public func scroll(to position: ScrollPosition, animated: Bool = true) {
        var offset = base.contentOffset
        switch position {
        case .top:
            offset.y = -base.contentInset.top
        case .left:
            offset.x = -base.contentInset.left
        case .bottom:
            offset.y = base.contentSize.height - base.bounds.size.height + base.contentInset.bottom
        case .right:
            offset.x = base.contentSize.width - base.bounds.size.width + base.contentInset.right
        }

        base.setContentOffset(offset, animated: animated)
    }
}

extension ExtrasKitWrapper where Base: UIScrollView {

    /// Take screenshot of view.
    ///
    /// - Parameter opaque: A Boolean flag indicating whether the bitmap is opaque.
    /// - Returns: A screenshot image of view.
    public func screenshot(_ opaque: Bool) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(base.contentSize, opaque, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }

        let savedContentOffset = base.contentOffset
        let savedFrame = base.frame
        let contentSize = base.contentSize
        let oldBounds = base.layer.bounds

        base.layer.bounds = CGRect(x: oldBounds.origin.x,
                                   y: oldBounds.origin.y,
                                   width: contentSize.width,
                                   height: contentSize.height)

        base.contentOffset = .zero
        base.frame = CGRect(
            x: 0, y: 0, width: base.contentSize.width, height: base.contentSize.height
        )

        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        base.layer.render(in: context)
        base.layer.bounds = oldBounds
        let image = UIGraphicsGetImageFromCurrentImageContext()

        base.frame = savedFrame // 恢复frame
        base.contentOffset = savedContentOffset // 如果不设置这一句，屏幕可能会移动

        return image
    }
}
