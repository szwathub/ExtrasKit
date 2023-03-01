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

class RootViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = "bbbbbb".ek.color
//        UIColor(hexString: )
        // Do any additional setup after loading the view, typically from a nib.
        if #available(iOS 14.0, *) {
            let picker = UIColorPickerViewController()
            picker.delegate = self
            present(picker, animated: true)
        } else {

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
//        UIColor(hexString: string)

        print(string)
    }
}