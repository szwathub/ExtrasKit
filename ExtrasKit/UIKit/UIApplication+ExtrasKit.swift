//
//  Copyright © 2023 ZhiweiSun. All rights reserved.
//
//  File name: UIApplication+ExtrasKit.swift
//  Author:    Zhiwei Sun @szwathub
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2023/7/27: Created by szwathub on 2023/7/27
//

import UIKit

@available(iOS 13.0, *)
extension UIApplication: ExtrasKitCompatible { }

@available(iOS 13.0, *)
extension ExtrasKitWrapper where Base: UIApplication {

    public var keyWindow: UIWindow? {
        return base.connectedScenes
            .compactMap {
                $0 as? UIWindowScene
            }
            .flatMap {
                $0.windows
            }
            .first {
                $0.isKeyWindow
            }
    }

    public var topViewController: UIViewController? {
        var topViewController = keyWindow?.rootViewController
        guard topViewController != nil else { return nil }
        while let controller = topViewController?.presentedViewController  {
            topViewController = controller
        }
        if let controller = topViewController as? UITabBarController {
            topViewController = controller.selectedViewController
        }
        if let controller = topViewController as? UINavigationController,
           controller.viewControllers.count > 1 {
            topViewController = controller.viewControllers.last
        }

        return topViewController
    }
}
