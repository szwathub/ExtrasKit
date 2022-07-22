//
//  Copyright © 2022 ZhiweiSun. All rights reserved.
//
//  File name: UIViewController+ExtrasKit.swift
//  Author:    Zhiwei Sun @szwathub
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2022/7/22: Created by szwathub on 2022/7/22
//

#if os(iOS)

import UIKit

extension UIViewController: ExtrasKitCompatible {
    
}

extension ExtrasKitWrapper where Base: UIViewController {

    /**
     Dismisses until there's only a single view controller.

     - Parameters:
        - animated: A Boolean flag indicating whether the animation is executed.
        - completion: A completion handler that is to be called right after the controller is
     dismissed (After the animation is concluded).
     */
    public func dismissToRootViewController(animated: Bool, completion: (() -> Void)? = nil) {
        guard let presenting = base.presentingViewController else {
            base.dismiss(animated: animated) {
                completion?()
            }
            return
        }

        presenting.ek.dismissToRootViewController(animated: animated, completion: completion)
    }
}

#endif
