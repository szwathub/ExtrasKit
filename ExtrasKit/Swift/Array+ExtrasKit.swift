//
//  Copyright © 2021 ZhiweiSun. All rights reserved.
//
//  File name: Array+ExtrasKit.swift
//  Author:    Zhiwei Sun @szwathub
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2021/12/3: Created by szwathub on 2021/12/3
//

import Foundation

extension Array where Element: Equatable {

    /// Removes the first given element
    ///
    /// - Parameter element: the element to be removed
    @discardableResult
    public mutating func removeFirst(_ element: Element) -> Index? {
        if let index = firstIndex(of: element) {
            remove(at: index)

            return index
        }

        return nil
    }
}
