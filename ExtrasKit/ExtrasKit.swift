//
//  Copyright © 2022 ZhiweiSun. All rights reserved.
//
//  File name: ExtrasKit.swift
//  Author:    Zhiwei Sun @szwathub
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2022/7/22: Created by szwathub on 2022/7/22
//

import Foundation

public struct ExtrasKitWrapper<Base> {

    public let base: Base

    public init(_ base: Base) {
        self.base = base
    }
}

public protocol ExtrasKitCompatible: AnyObject { }

public protocol ExtrasKitCompatibleValue { }

/// Gets a namespace holder for ExtrasKit compatible types.
extension ExtrasKitCompatible {
    public static var ek: ExtrasKitWrapper<Self>.Type {
        return ExtrasKitWrapper<Self>.self
    }

    public var ek: ExtrasKitWrapper<Self> {
        return ExtrasKitWrapper(self)
    }
}

extension ExtrasKitCompatibleValue {
    public static var ek: ExtrasKitWrapper<Self>.Type {
        return ExtrasKitWrapper<Self>.self
    }

    public var ek: ExtrasKitWrapper<Self> {
        return ExtrasKitWrapper(self)
    }
}
