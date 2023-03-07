//
//  Copyright © 2023 ZhiweiSun. All rights reserved.
//
//  File name: UIImpactFeedbackGenerator+ExtrasKit.swift
//  Author:    Zhiwei Sun @szwathub
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2023/3/7: Created by szwathub on 2023/3/7
//

import UIKit

@available(iOS 10.0, *)
extension UIImpactFeedbackGenerator: ExtrasKitCompatible { }

@available(iOS 10.0, *)
extension ExtrasKitWrapper where Base: UIImpactFeedbackGenerator {

    /// Triggers impact feedback with a specific intensity and a specific value based on the
    /// `UIImpactFeedbackGenerator.FeedbackStyle`
    ///
    /// - Parameters:
    ///   - style: A value representing the mass of the colliding objects. For a list of valid
    ///   feedback styles, see the `UIImpactFeedbackGenerator.FeedbackStyle` enumeration.
    ///   - intensity: A CGFloat value between 0.0 and 1.0. Defaults to 1.0.
    public static func impact(style: UIImpactFeedbackGenerator.FeedbackStyle, intensity: CGFloat = 1.0) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        if #available(iOS 13.0, *) {
            generator.impactOccurred(intensity: intensity)
        } else {
            generator.impactOccurred()
        }
    }
}
