//
//  ViewController.swift
//  BusApp
//
//  Created by Meinhard Benedict Capucao on 10/28/19.
//  Copyright © 2019 Meinhard Benedict Capucao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var rememberMeBox: UIButton!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    var tempDatabase = ["Joe": "Mama", "Bruh": "Moment"]
    
    @IBAction func submitButton(_ sender: Any) {

        
    }
    
    override func viewDidLoad() {
        rememberMeBox.backgroundColor = UIColor.clear
        rememberMeBox.layer.borderWidth = 1
        rememberMeBox.layer.borderColor = UIColor.white.cgColor
        // Do any additional setup after loading the view.
    }


}

