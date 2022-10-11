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

    /// Base object to extend.
    public var base: Base

    /// Creates extensions with base object.
    ///
    /// - Parameter base: Base object.
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol ExtrasKitCompatible: AnyObject { }

public protocol ExtrasKitCompatibleValue { }

/// Gets a namespace holder for ExtrasKit compatible types.
extension ExtrasKitCompatible {
    public static var ek: ExtrasKitWrapper<Self>.Type {
        get { ExtrasKitWrapper<Self>.self }
        // this enables using ExtrasKit to "mutate" base type
        // swiftlint:disable:next unused_setter_value
        set { }
    }

    public var ek: ExtrasKitWrapper<Self> {
        get { ExtrasKitWrapper(self) }
        // this enables using ExtrasKit to "mutate" base type
        // swiftlint:disable:next unused_setter_value
        set { }
    }
}

extension ExtrasKitCompatibleValue {
    public static var ek: ExtrasKitWrapper<Self>.Type {
        get { ExtrasKitWrapper<Self>.self }
        // this enables using ExtrasKit to "mutate" base type
        // swiftlint:disable:next unused_setter_value
        set { }
    }

    public var ek: ExtrasKitWrapper<Self> {
        get { ExtrasKitWrapper(self) }
        // this enables using ExtrasKit to "mutate" base type
        // swiftlint:disable:next unused_setter_value
        set { }
    }
}
