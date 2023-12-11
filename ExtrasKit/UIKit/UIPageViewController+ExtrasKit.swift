//
//  Copyright © 2023 ZhiweiSun. All rights reserved.
//
//  File name: UIPageViewController+ExtrasKit.swift
//  Author:    Zhiwei Sun @szwathub
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2023/12/11: Created by szwathub on 2023/12/11
//

#if os(iOS)

import UIKit

extension ExtrasKitWrapper where Base: UIPageViewController {

    /// default YES. turn off any dragging temporarily
    public var isPagingEnabled: Bool {
        get {
            return scrollView?.isScrollEnabled ?? false
        }
        set {
            scrollView?.isScrollEnabled = newValue
        }
    }

    private var scrollView: UIScrollView? {
        return base.view.subviews.first { $0 is UIScrollView } as? UIScrollView
    }
}

#endif
