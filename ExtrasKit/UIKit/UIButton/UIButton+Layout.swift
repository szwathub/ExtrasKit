//
//  Copyright © 2020 ZhiweiSun. All rights reserved.
//
//  File name: UIButton+Layout.swift
//  Author:    Zhiwei Sun @szwathub
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2020/12/25: Created by szwathub on 2020/12/25
//

import Foundation

extension ExtrasKitWrapper where Base: UIButton {
    public enum ButtonLayout: Int {
        case imageLeftTitleRight = 0
        case imageRightTitleLeft = 1
        case imageTopTitleBottom = 2
        case imageBottomTitleTop = 3
    }

    /// Adjust the position of the icon and text in the button.
    ///
    /// - Parameters:
    ///     - layout: layout of buttons.
    ///     - spacing: Space between icon and text.
    ///
    public func setLayout(_ layout: ButtonLayout, spacing: CGFloat) {
        if let image = base.imageView?.image, let font = base.titleLabel?.font, let title = base.titleLabel?.text {
            let imageWidth = image.size.width
            let imageHeight = image.size.height
            let labelWidth = title.size(withAttributes: [NSAttributedString.Key.font: font]).width
            let labelHeight = title.size(withAttributes: [NSAttributedString.Key.font: font]).height

            let imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2 // image中心移动的x距离
            let imageOffsetY = labelHeight / 2 + spacing / 2 // image中心移动的y距离
            let labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2 // label中心移动的x距离
            let labelOffsetY = imageHeight / 2 + spacing / 2 // label中心移动的y距离

            switch layout {
            case .imageLeftTitleRight:
                base.imageEdgeInsets = UIEdgeInsets(top: 0,
                                                   left: -spacing / 2,
                                                 bottom: 0,
                                                  right: spacing / 2)
                base.titleEdgeInsets = UIEdgeInsets(top: 0,
                                                   left: spacing / 2,
                                                 bottom: 0,
                                                  right: -spacing / 2)
            case .imageRightTitleLeft:
                base.imageEdgeInsets = UIEdgeInsets(top: 0,
                                                   left: labelWidth + spacing / 2,
                                                 bottom: 0,
                                                  right: -(labelWidth + spacing / 2))
                base.titleEdgeInsets = UIEdgeInsets(top: 0,
                                                   left: -(imageHeight + spacing / 2),
                                                 bottom: 0,
                                                  right: imageHeight + spacing / 2)
            case .imageTopTitleBottom:
                base.imageEdgeInsets = UIEdgeInsets(top: -imageOffsetY,
                                                   left: imageOffsetX,
                                                 bottom: imageOffsetY,
                                                  right: -imageOffsetX)
                base.titleEdgeInsets = UIEdgeInsets(top: labelOffsetY,
                                                   left: -labelOffsetX,
                                                 bottom: -labelOffsetY,
                                                  right: labelOffsetX)
            case .imageBottomTitleTop:
                base.imageEdgeInsets = UIEdgeInsets(top: imageOffsetY,
                                                   left: imageOffsetX,
                                                 bottom: -imageOffsetY,
                                                  right: -imageOffsetX)
                base.titleEdgeInsets = UIEdgeInsets(top: -labelOffsetY,
                                                   left: -labelOffsetX,
                                                 bottom: labelOffsetY,
                                                  right: labelOffsetX)
            }

            base.setNeedsLayout()
        }
    }
}
