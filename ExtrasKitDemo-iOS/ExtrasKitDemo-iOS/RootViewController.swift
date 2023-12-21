//
//  Copyright © 2021 ZhiweiSun. All rights reserved.
//
//  File name: RootViewController.swift
//  Author:    ZhiweiSun @szwathub
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      03/18/2021: Created by szwathub on 03/18/2021
//

import UIKit
import ExtrasKit

struct Student {
    var name: String
}

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = "bbbbbb".ek.color

        var asd = [1, 2, 9]
        let result = asd.ek.diff([1, 2, 3], [2, 3, 4], [4, 5, 6]) { $0 }
        print(result)

//        var students: [Student] = [
//            Student(name: "Vivien"), Student(name: "Marlon"), Student(name: "Kim")
//        ]
//        let difference = students.ek.diff([Student(name: "Vivien")], where: \.name)
//        print(difference)
        // Prints "[Student(name: "Marlon"), Student(name: "Kim")]"
    }
}

@available(iOS 14.0, *)
extension RootViewController: UIColorPickerViewControllerDelegate {

    func colorPickerViewController(_ viewController: UIColorPickerViewController,
                                   didSelect color: UIColor,
                                   continuously: Bool) {

        guard let string = color.ek.hexString else {
            return
        }

        view.backgroundColor = string.ek.color

        print(string)
    }
}

extension Array {
    func withoutDuplicates<E: Equatable>(keyPath path: KeyPath<Element, E>) -> [Element] {
            return reduce(into: [Element]()) { result, element in
                if !result.contains(where: { $0[keyPath: path] == element[keyPath: path] }) {
                    result.append(element)
                }
            }
        }

    func difference <T: Equatable> (values: [T]...) -> [T] {

            var result = [T]()

            elements: for e in self {
                if let element = e as? T {
                    for value in values {
                        //  if a value is in both self and one of the values arrays
                        //  jump to the next iteration of the outer loop
                        if value.contains(element) {
                            continue elements
                        }
                    }

                    //  element it's only in self
                    result.append(element)
                }
            }

            return result

        }
}
