//
//  Copyright © 2020 ZhiweiSun. All rights reserved.
//
//  File name: UIImage+Orientation.swift
//  Author:    Zhiwei Sun @szwathub
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2020/12/25: Created by szwathub on 2020/12/25
//

import Foundation

extension ExtrasKitWrapper where Base: UIImage {
    /// Fix image rotation.
    ///
    /// - Returns: A fixed iamge. If not return the origin image.
    ///
    public func fixOrientation() -> UIImage? {
        // No-op if the orientation is already correct
        if base.imageOrientation == UIImage.Orientation.up {
            return base
        }

        // Make sure that this image has an CGImage attached.
        guard let cgImage = base.cgImage else {
            return nil
        }

        // Create a CGContext to draw the rotated image to.
        guard let colorSpace = cgImage.colorSpace,
              let context = CGContext(data: nil,
                                     width: Int(base.size.width),
                                    height: Int(base.size.height),
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

        switch base.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            context.draw(cgImage, in: CGRect(x: 0, y: 0, width: base.size.height, height: base.size.width))
        default:
            context.draw(cgImage, in: CGRect(x: 0, y: 0, width: base.size.width, height: base.size.height))
        }

        // Create a CGImage from the context.
        guard let newCGImage = context.makeImage() else {
            return nil
        }

        return UIImage.init(cgImage: newCGImage)
    }

    private func calculateTransformationMatrix(transform: inout CGAffineTransform) {
        switch base.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: base.size.width, y: base.size.height)
            transform = transform.rotated(by: CGFloat.pi)
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: base.size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2.0)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: base.size.height)
            transform = transform.rotated(by: CGFloat.pi / -2.0)
        default:
            break
        }

        // If the image is mirrored then flip it.
        switch base.imageOrientation {
        case .upMirrored, .downMirrored:
            transform.translatedBy(x: base.size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform.translatedBy(x: base.size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)
        default:
            break
        }
    }
}
