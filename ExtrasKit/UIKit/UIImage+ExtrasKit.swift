//
//  Copyright © 2021 ZhiweiSun. All rights reserved.
//
//  File name: UIImage+ExtrasKit.swift
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

extension UIImage {

    /// Initializes and returns the image object with color and size.
    ///
    /// - Parameters:
    ///   - color: The image color.
    ///   - size: The image size. Defaults to CGSize(width: 10.0, height: 10.0).
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 10.0, height: 10.0)) {
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

        self.init(cgImage: cgImage)
    }

    /// Initializes and returns the image object by pairing the colors provided in `colors` with the locations
    /// provided in `locations`.
    ///
    /// - Parameters:
    ///   - colors: The `colors` should be a non-empty array of CGColor objects.
    ///   - startPoint: The `startPoint` corresponds to the first gradient stop. Default to CGPoint(x: 0.5, y: 0.0).
    ///   - endPoint: The `endPoint` corresponds to the last gradient stop. Default to CGPoint(x: 0.5, y: 1.0)
    ///   - size: The image size. Defaults to CGSize(width: 10.0, height: 10.0).
    ///   - locations: An optional array defining the location of each gradient stop as a value in the range [0,1],
    ///         which should hould contain the same number of items as `colors` and the values must be monotonically
    ///         increasing. If `locations` is NULL, the first color in `colors` will be at location 0, the last color
    ///         in `colors` will be at location 1.
    ///
    public convenience init?(colors: [CGColor],
                             startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0),
                             endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0),
                             size: CGSize = CGSize(width: 10.0, height: 10.0),
                             locations: [CGFloat] = [0.0, 1.0]) {

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

        self.init(cgImage: cgImage)
    }
}

extension UIImage {

    /// Fix image rotation.
    ///
    /// - Returns: A fixed iamge. If not return the origin image.
    public func fixOrientation() -> UIImage? {
        // No-op if the orientation is already correct
        if imageOrientation == UIImage.Orientation.up {
            return self
        }

        // Make sure that this image has an CGImage attached.
        guard let cgImage = cgImage else {
            return nil
        }

        // Create a CGContext to draw the rotated image to.
        guard let colorSpace = cgImage.colorSpace,
              let context = CGContext(data: nil,
                                      width: Int(size.width),
                                      height: Int(size.height),
                                      bitsPerComponent: cgImage.bitsPerComponent,
                                      bytesPerRow: 0,
                                      space: colorSpace,
                                      bitmapInfo: cgImage.bitmapInfo.rawValue) else {

                return nil
        }

        var transform: CGAffineTransform = CGAffineTransform.identity
        // Calculate the transformation matrix that needed to bring the image orientation to .up
        calculateTransformationMatrix(transform: &transform)

        // Apply transformation matrix to the CGContext.
        context.concatenate(transform)

        switch imageOrientation {
            case .left, .leftMirrored, .right, .rightMirrored:
                context.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
            default:
                context.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        }

        // Create a CGImage from the context.
        guard let newCGImage = context.makeImage() else {
            return nil
        }

        return UIImage.init(cgImage: newCGImage)
    }

    private func calculateTransformationMatrix(transform: inout CGAffineTransform) {
        switch imageOrientation {
            case .down, .downMirrored:
                transform = transform.translatedBy(x: size.width, y: size.height)
                transform = transform.rotated(by: CGFloat.pi)
            case .left, .leftMirrored:
                transform = transform.translatedBy(x: size.width, y: 0)
                transform = transform.rotated(by: CGFloat.pi / 2.0)
            case .right, .rightMirrored:
                transform = transform.translatedBy(x: 0, y: size.height)
                transform = transform.rotated(by: CGFloat.pi / -2.0)
            default:
                break
        }

        // If the image is mirrored then flip it.
        switch imageOrientation {
            case .upMirrored, .downMirrored:
                transform = transform.translatedBy(x: size.width, y: 0)
                transform = transform.scaledBy(x: -1, y: 1)
            case .leftMirrored, .rightMirrored:
                transform = transform.translatedBy(x: size.height, y: 0)
                transform = transform.scaledBy(x: -1, y: 1)
            default:
                break
        }
    }
}

extension UIImage {

    /// Scele the image to the given size.
    ///
    /// - Parameter size: The size to scale to.
    /// - Returns: Returns the scaled image.
    public func resize(_ size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        self.draw(in: CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }

    /// Create an image using the image contained within the subrectangle `rect` of `image`.
    ///
    /// - Parameter rect: Rect to crop image to.
    /// - Returns: Returns the cropped iamge.
    public func cropping(to rect: CGRect) -> UIImage? {
        var newRect = rect
        newRect.origin.x    *= scale
        newRect.origin.y    *= scale
        newRect.size.width  *= scale
        newRect.size.height *= scale

        guard let imageRef = cgImage?.cropping(to: newRect) else {
            return nil
        }

        return UIImage(cgImage: imageRef, scale: self.scale, orientation: .up)
    }
}

#endif
