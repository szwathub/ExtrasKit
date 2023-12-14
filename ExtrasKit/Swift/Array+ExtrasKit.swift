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

extension Array: ExtrasKitCompatibleValue { }

extension ExtrasKitWrapper where Base: RangeReplaceableCollection, Base.Element: Equatable {

    /// Removes the first given element from the list if it is already present.
    ///
    /// if `element` was not contained in the list, this method has no effect.
    /// In the following example, a element is remoed from `listOfNumber`, When an
    /// no-existing element is removed, the `listOfNumber` list does not change.
    ///
    ///     var listOfNumber = [1, 2]
    ///     print(listOfNumber.ek.removeFirst(0))
    ///     // Prints "(removed: nil, listAfterRemoved: [1, 2])"
    ///
    ///     print(listOfNumber.ek.removeFirst(1))
    ///     // Prints "(removed: Optional(0), listAfterRemoved: [2])"
    ///
    /// - Parameter element: An element to removed from the list.
    /// - Returns: `(nil, oldList)` if `element` was not contained in the
    ///   list. If an element equal to `element` was already contained in the
    ///   list, the method returns `(index, newList)`, where `index` is the
    ///   first position of the element to remove.
    public mutating func removeFirst(_ element: Base.Element) -> (removed: Base.Index?, listAfterRemoved: Base) {
        if let index = base.firstIndex(of: element) {
            base.remove(at: index)
            return (index, base)
        }

        return (nil, base)
    }

    /// Returns a new collection of the same type containing, in order, the
    /// elements of the original collection that remove all duplicate elements.
    ///
    ///     var cast = ["Vivien", "Marlon", "Kim", "Karl", "Vivien"]
    ///     let deduplication = cast.ek.deduplicate { $0 }
    ///     print(deduplication)
    ///     // Prints "["Vivien", "Marlon", "Kim", "Karl"]"
    ///
    /// - Parameter filter: A closure that takes an element of the
    ///   sequence as its argument and returns returns a transformed value indicating
    ///   whether the element is duplicated and original element should be included
    ///   in the returned collection.
    /// - Returns: A collection of the elements after removing all duplicate elements.
    ///
    /// - Complexity: O(*n * n*), where *n* is the length of the collection.
    public mutating func deduplicate<E: Equatable>(_ filter: (Base.Element) -> E) -> [Base.Element] {

        return base.reduce([]) { unique, element in
            let key = filter(element)
            if !unique.map({ filter($0) }).contains(key) {
                return unique + [element]
            }

            return unique
        }
    }
}

extension ExtrasKitWrapper where Base: Sequence, Base.Element: AdditiveArithmetic {

    /// Calculates and return the total of any sequence with `AdditiveArithmetic` elements
    public var sum: Base.Element {
        return base.reduce(.zero, +)
    }
}

extension ExtrasKitWrapper where Base: Collection {

    /// Accesses the element at the specified index in a safe way.
    ///
    /// - Parameter index: The index of the element to access.
    /// - Returns: `nil` if `index` isn't be in the range `indices`. otherwise the element
    /// at the specified index.
    public subscript(safe index: Base.Index) -> Base.Element? {
        guard base.indices.contains(index) else {
            return nil
        }

        return base[index]
    }
}
