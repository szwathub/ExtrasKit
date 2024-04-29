//
//  Copyright © 2024 ZhiweiSun. All rights reserved.
//
//  File name: Dictionary+ExtrasKit.swift
//  Author:    Zhiwei Sun @szwathub
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2024/4/29: Created by szwathub on 2024/4/29
//

import Foundation

extension Dictionary: ExtrasKitCompatibleValue { }

extension ExtrasKitWrapper where Base == [AnyHashable: Any] {

    func hasValue(key: Base.Key) -> Bool {
        return base[key] != nil
    }
}
