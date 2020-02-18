//
//  ViewController.swift
//  BusAppDevelopment
//
//  Created by Meinhard Benedict Capucao on 11/15/19.
//  Copyright © 2019 Meinhard Benedict Capucao. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet var usernameField: UITextField!
    
    @IBOutlet var passwordField: UITextField!
    
    @IBOutlet var logInButton: UIButton!

    @IBOutlet var createAccount: UIButton!
    
    @IBOutlet var alreadyHaveAnAccount: UIButton!
    
    @IBOutlet var invalidPassword: UILabel!
    
    @IBAction func buttonTapped(_ sender: Any) {
        handleLogin()
    }
    
    @IBAction func createTapped(_ sender: Any) {
        handleRegister()
    }
    

    
    func handleRegister() {
        guard let username = usernameField.text, let password = passwordField.text else{
            print("Form is not valid")
            return
        }
        Auth.auth().createUser(withEmail: username, password: password) { user, error in
            if error != nil{
                self.invalidPassword.isHidden = false
                return
            }
            let values = ["isAdmin": "false", "isDone": "false"]
            let ref = Database.database().reference()
            let userID = Auth.auth().currentUser?.uid
            let usersRef = ref.child("users").child(userID!)
            usersRef.updateChildValues(values) { (err, ref) in
                
                if err != nil{
                    print(err!)
                    return
                }
            }
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "Setup")
            self.present(secondViewController!, animated: true, completion: nil)
        }
    }
    
    func handleLogin() {
        guard let username = usernameField.text, let password = passwordField.text else{
                print("Form is not valid")
                return
            }
        Auth.auth().signIn(withEmail: username, password: password) { user, error in
            if error != nil{
                self.invalidPassword.isHidden = false
                return
            }
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AppContainerViewController")
            self.present(secondViewController!, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestNotificationAuthorization()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        usernameField.layer.borderColor = UIColor.white.cgColor
        passwordField.layer.borderColor = UIColor.white.cgColor
        
  
        
        usernameField.delegate = self
        passwordField.delegate = self
        usernameField.tag = 0
        passwordField.tag = 1
        
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (keyboardSize.height/2)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

}

