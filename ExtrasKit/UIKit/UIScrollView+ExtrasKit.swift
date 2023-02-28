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
