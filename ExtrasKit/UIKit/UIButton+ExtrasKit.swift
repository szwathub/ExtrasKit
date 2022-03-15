//
//  Copyright © 2021 ZhiweiSun. All rights reserved.
//
//  File name: UIButton+ExtrasKit.swift
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

extension UIButton {
    public enum Layout {
        /// image top title bottom
        case imageTop

        /// image left title right
        case imageLeft

        // image right title left
        case imageRight

        /// image bottom title top
        case imageBottom
    }

    /// Adjust the position of the icon and text in the button.
    ///
    /// - Parameters:
    ///   - layout: layout of buttons.
    ///   - spacing: Space between image and text.
    public func setLayout(_ layout: Layout, spacing: CGFloat) {
        guard let image = imageView?.image, let font = titleLabel?.font, let title = titleLabel?.text else {
            return
        }

        let iSize = image.size
        let lSize = title.size(withAttributes: [NSAttributedString.Key.font: font])

        let inset = spacing / 2
        let offsetI = CGPoint(
            x: (iSize.width + lSize.width) / 2 - iSize.width / 2,
            y: lSize.height / 2 + inset
        )
        let offsetT = CGPoint(
            x: (iSize.width + lSize.width / 2) - (iSize.width + lSize.width) / 2,
            y: iSize.height / 2 + inset
        )

        switch layout {
            case .imageTop:
                imageEdgeInsets = .init(top: -offsetI.y, left: offsetI.x, bottom: offsetI.y, right: -offsetI.x)
                titleEdgeInsets = .init(top: offsetT.y, left: -offsetT.x, bottom: -offsetT.y, right: offsetT.x)
            case .imageLeft:
                imageEdgeInsets = .init(top: 0, left: -inset, bottom: 0, right: inset)
                titleEdgeInsets = .init(top: 0, left: inset, bottom: 0, right: -inset)
            case .imageRight:
                imageEdgeInsets = .init(top: 0, left: lSize.width + inset, bottom: 0, right: -(lSize.width + inset))
                titleEdgeInsets = .init(top: 0, left: -(iSize.height + inset), bottom: 0, right: iSize.height + inset)
            case .imageBottom:
                imageEdgeInsets = .init(top: offsetI.y, left: offsetI.x, bottom: -offsetI.y, right: -offsetI.x)
                titleEdgeInsets = .init(top: -offsetT.y, left: -offsetT.x, bottom: offsetT.y, right: offsetT.x)
        }

        setNeedsLayout()
    }
}

#endif
