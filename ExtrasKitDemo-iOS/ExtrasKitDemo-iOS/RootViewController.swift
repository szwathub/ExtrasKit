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
//        var asd = [1, 2, 9]
//        var result = asd.ek.intersection([1, 2, 3], [2, 3, 4], [2, 4, 5, 6]) { $0 }
//        print(asd)
//        print(result)

        var asd = [1, 1, 2, 3]
//        print(asd.ek.union([2, 3, 4], where: { $0 }))
//        print(asd)
        print(asd.ek[random: 9])
    }
}
