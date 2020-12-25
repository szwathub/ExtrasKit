//
//  Copyright © 2020 ZhiweiSun. All rights reserved.
//
//  File name: UIImage+Color.swift
//  Author:    Zhiwei Sun @szwathub
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2020/12/24: Created by szwathub on 2020/12/24
//

import Foundation

extension ExtrasKitWrapper where Base: UIImage {
    /// Creates an image with color and size.
    ///
    /// - Parameters:
    ///     - color: The image color.
    ///     - size: The image size. Defaults to CGSize(width: 10.0, height: 10.0).
    ///
    public static func with(color: UIColor, size: CGSize = CGSize(width: 10.0, height: 10.0)) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }

        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(origin: CGPoint.zero, size: size))
        context?.setShouldAntialias(true)

        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            return nil
        }

        return UIImage(cgImage: cgImage)
    }

    /// Creates a gradient image by pairing the colors provided in `colors` with the locations provided in `locations`.
    ///
    /// - Parameters:
    ///     - colors: The `colors` should be a non-empty array of CGColor objects.
    ///     - startPoint: The `startPoint` corresponds to the first gradient stop. Default to CGPoint(x: 0.5, y: 0.0).
    ///     - endPoint: The `endPoint` corresponds to the last gradient stop. Default to CGPoint(x: 0.5, y: 1.0)
    ///     - size: The image size. Defaults to CGSize(width: 10.0, height: 10.0).
    ///     - locations: An optional array defining the location of each gradient stop as a value in the range [0,1],
    ///                  which should hould contain the same number of items as `colors` and the values must be
    ///                  monotonically increasing. If `locations` is NULL, the first color in `colors` will be at
    ///                  location 0, the last color in `colors` will be at location 1.
    ///
    public static func with(colors: [CGColor],
                        startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0),
                          endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0),
                              size: CGSize = CGSize(width: 10.0, height: 10.0),
                         locations: [CGFloat] = [0.0, 1.0]) -> UIImage? {

        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }

        let context = UIGraphicsGetCurrentContext()
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                             colors: colors as CFArray,
                                          locations: locations) else {
            return nil
        }

        let sPoint = CGPoint(x: min(max(0.0, startPoint.x), 1.0) * size.width,
                             y: min(max(0.0, startPoint.y), 1.0) * size.height)
        let ePoint = CGPoint(x: min(max(0.0, endPoint.x), 1.0)  * size.width,
                             y: min(max(0.0, endPoint.y), 1.0)  * size.height)

        context?.drawLinearGradient(gradient, start: sPoint, end: ePoint, options: .drawsBeforeStartLocation)

        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            return nil
        }

        return UIImage(cgImage: cgImage)
    }

    /// Sets the fill and stroke colors for image.
    ///
    /// - Parameters:
    ///     - color: The fill and stroke color.
    /// - Returns: A new image with fill and stroke color.
    ///
    public func with(renderColor: UIColor) -> UIImage? {
        let result = base.withRenderingMode(.alwaysTemplate)

        UIGraphicsBeginImageContextWithOptions(result.size, false, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }

        renderColor.set()
        result.draw(in: CGRect.init(origin: .zero, size: result.size))

        let image = UIGraphicsGetImageFromCurrentImageContext()

        return image
    }
}
