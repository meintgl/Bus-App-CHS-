//
//  ViewController.swift
//  BusAppDevelopment
//
//  Created by Meinhard Benedict Capucao on 11/15/19.
//  Copyright © 2019 Meinhard Benedict Capucao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        usernameField.layer.borderColor = UIColor.white.cgColor
        passwordField.layer.borderColor = UIColor.white.cgColor
        
        logInButton.layer.cornerRadius = 5
        
    }


}

