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
        let result = asd.ek.intersection([1, 2, 3], [2, 3, 4], [2, 4, 5, 6]) { $0 }
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
