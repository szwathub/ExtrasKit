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
}

extension ExtrasKitWrapper where Base: Sequence {

    /// Returns a new sequence of the same type containing, in order, the
    /// unique elements in the original sequence.
    ///
    ///     var cast = ["Vivien", "Marlon", "Kim", "Karl", "Vivien"]
    ///     let unique = cast.ek.unique { $0 }
    ///     print(unique)
    ///     // Prints "["Vivien", "Marlon", "Kim", "Karl"]"
    ///
    /// In this example, `predicate` indicating whether the element is unique
    /// and original element should be included in the returned sequence
    /// by using `KeyPath`.
    ///
    ///     struct Student {
    ///         var name: String
    ///     }
    ///
    ///     var students: [Student] = [
    ///         Student(name: "Vivien"), Student(name: "Marlon"), Student(name: "Vivien")
    ///     ]
    ///     let unique = students.ek.unique(\.name)
    ///     print(unique)
    ///     // Prints "[Student(name: "Vivien"), Student(name: "Marlon")]"
    ///
    /// - Parameter predicate: A closure that takes an element of the
    ///   sequence as its argument and returns a transformed value indicating
    ///   whether the element is unique and original element should be included
    ///   in the returned sequence.
    /// - Returns: A sequence of the elements consisting of the unique elements
    ///   in the original sequence.
    ///
    /// - Complexity: O(*n * n*), where *n* is the length of the sequence.
    public mutating func unique<E>(_ predicate: (Base.Element) -> E) -> [Base.Element]
    where E: Equatable {
        return base.reduce(into: []) { unique, element in
            if !unique.contains(where: { predicate($0) == predicate(element) }) {
                unique.append(element)
            }
        }
    }

    /// Returns a new sequence of the same type containing, in order, the
    /// difference elements in the original sequence and the given sequences.
    ///
    ///     var cast = ["Vivien", "Marlon", "Kim", "Karl", "Vivien"]
    ///     let difference = cast.ek.diff(["Vivien"]) { $0 }
    ///     print(difference)
    ///     // Prints "["Marlon", "Kim", "Karl"]"
    ///     
    /// In this example, `predicate` indicating whether the element is unique
    /// and original element should be included in the returned sequence
    /// by using `KeyPath`.
    ///
    ///     var students: [Student] = [
    ///         Student(name: "Vivien"), Student(name: "Marlon"),
    ///         Student(name: "Kim")
    ///     ]
    ///     let difference = students.ek.diff([Student(name: "Vivien")], where: \.name)
    ///     print(difference)
    ///     // Prints "[Student(name: "Marlon"), Student(name: "Kim")]"
    ///
    /// - Parameters:
    ///   - others: A list of sequences of the elements subtracted from original sequence.
    ///   - predicate: A closure that takes an element of the sequence as its
    ///   argument and returns a transformed value indicating whether the element
    ///   is unique and original element should be included in the returned sequence.
    /// - Returns: A sequence of the elements which is difference between the original
    ///   sequence and the given sequence.
    ///
    /// - Complexity: O(*n * m*), where *n* is the length of the sequence and
    ///   *m* is the number of elements in the given sequences.
    public mutating func diff<S, E>(_ others: S..., where predicate: (Base.Element) -> E) -> [Base.Element]
    where S: Sequence, E: Equatable, S.Element == Base.Element {
        let other = others.flatMap { $0 }
        return base.reduce(into: []) { difference, element in
            if !other.contains(where: { predicate($0) == predicate(element) }) {
                difference.append(element)
            }
        }
    }

    /// Returns a new sequence of the same type containing, in order, the
    /// intersective elements in the original sequence and the given sequences.
    ///
    ///     var cast = ["Vivien", "Marlon", "Kim", "Karl", "Vivien"]
    ///     let intersection = cast.ek.intersection(["Vivien"]) { $0 }
    ///     print(intersection)
    ///     // Prints "["Vivien"]"
    ///
    /// In this example, `predicate` indicating whether the element is intersective
    /// and original element should be included in the returned sequence by using `KeyPath`.
    ///
    ///     var stu: [Student] = [
    ///         Student(name: "Vivien"), Student(name: "Marlon"),
    ///         Student(name: "Kim")
    ///     ]
    ///     let intersection = stu.ek.intersection([Student(name: "Vivien")], where: \.name)
    ///     print(intersection)
    ///     // Prints "[Student(name: "Vivien")]"
    ///
    /// - Parameters:
    ///   - others: A list of sequences of the elements intersected from original sequence.
    ///   - predicate: A closure that takes an element of the sequence as its
    ///   argument and returns a transformed value indicating whether the element
    ///   is intersective and original element should be included in the returned sequence.
    /// - Returns: A sequence of the elements which is intersective between the original
    ///   sequence and the given sequence.
    ///
    /// - Complexity: O(*n * m*), where *n* is the length of the sequence and
    ///   *m* is the number of elements in the given sequences.
    public mutating func intersection<S, E>(_ others: S..., where predicate: (Base.Element) -> E) -> [Base.Element]
    where S: Sequence, E: Equatable, S.Element == Base.Element {
        var result = base.map { $0 }
        var intersection: [Base.Element] = []

        for other in others {
            //  find common elements and save them in first set
            //  to intersect in the next loop
            intersection = other.reduce(into: []) { partial, element in
                if result.contains(where: { predicate($0) == predicate(element) }) {
                    partial.append(element)
                }
            }

            if intersection.isEmpty {
                return intersection
            }

            result = intersection
            intersection = []
        }

        return result
    }

    /// Returns a new sequence of the same type containing, in order, the
    /// union elements in the original sequence and the given sequences.
    ///
    ///     var cast = ["Vivien", "Marlon", "Vivien"]
    ///     let union = cast.ek.union(["Vivien", "Kim", "Karl"]) { $0 }
    ///     print(union)
    ///     // Prints "["Vivien", "Marlon", "Kim", "Karl"]"
    ///
    /// In this example, `predicate` indicating whether the element is equal
    /// to original element should be included in the returned sequence by using `KeyPath`.
    ///
    ///     var stu: [Student] = [
    ///         Student(name: "Vivien"), Student(name: "Marlon")
    ///     ]
    ///     let union = stu.ek.union([Student(name: "Vivien"), Student(name: "Kim")], where: \.name)
    ///     print(union)
    ///     // Prints "[Student(name: "Vivien"), Student(name: "Marlon"), Student(name: "Kim")]"
    ///
    /// - Parameters:
    ///   - others: A list of sequences of the elements unioned from original sequence.
    ///   - predicate: A closure that takes an element of the sequence as its
    ///   argument and returns a transformed value indicating whether the element
    ///   is equal to original element should be included in the returned sequence.
    /// - Returns: A sequence of the elements which is union between the original
    ///   sequence and the given sequence.
    ///
    /// - Complexity: O(*n * m*), where *n* is the length of the sequence and
    ///   *m* is the number of elements in the given sequences.
    public mutating func union<S, E>(_ others: S..., where predicate: (Base.Element) -> E) -> [Base.Element]
    where S: Sequence, E: Equatable, S.Element == Base.Element {
        var map = base.map { $0 }
        map.append(contentsOf: others.flatMap { $0 })
        return map.reduce(into: []) { union, element in
            if !union.contains(where: { predicate($0) == predicate(element) }) {
                union.append(element)
            }
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

    /// Accesses random elements.
    ///
    /// - Parameter count: The number of randomly accessed elements.
    /// - Returns: A sequence of randomly accessed elements.
    public subscript (random count: Int) -> [Base.Element] {
        var map = base.map { $0 }
        guard count <= base.count else {
            return map
        }

        return map.shuffled().suffix(count).map { $0 }
    }
}
