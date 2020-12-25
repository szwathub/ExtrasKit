//
//  Copyright © 2020 ZhiweiSun. All rights reserved.
//
//  File name: ExtrasKit.swift
//  Author:    Zhiwei Sun @szwathub
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2020/12/24: Created by szwathub on 2020/12/24
//

import Foundation

public struct ExtrasKitWrapper<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol ExtrasKitCompatible: AnyObject { }

/// Gets a namespace holder for ExtrasKit compatible types.
extension ExtrasKitCompatible {
    public static var esk: ExtrasKitWrapper<Self>.Type {
        return ExtrasKitWrapper<Self>.self
    }

    public var esk: ExtrasKitWrapper<Self> {
        return ExtrasKitWrapper(self)
    }
}
