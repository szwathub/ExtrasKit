//
//  Copyright © 2021 ZhiweiSun. All rights reserved.
//
//  File name: ViewController.swift
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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let asd = UIImage(color: .red, size: CGSize(width: 100, height: 100))
        let imageView = UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        imageView.image = asd

        let button = UIButton()

        view.addSubview(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
