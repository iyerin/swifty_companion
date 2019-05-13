//
//  ViewController.swift
//  swifty_companion
//
//  Created by Ihor YERIN on 09/05/2019.
//  Copyright © 2019 Ihor YERIN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func serchButton(_ sender: UIButton) {
        if let login = loginLabel.text {
            UserData.shared.myUser.login = login
        } else { return }
    }
    @IBOutlet weak var loginLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

