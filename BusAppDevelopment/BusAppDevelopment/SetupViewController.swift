//
//  SetupViewController.swift
//  BusAppDevelopment
//
//  Created by Ricky Titus on 2/3/20.
//  Copyright © 2020 Meinhard Benedict Capucao. All rights reserved.
//

import UIKit
import Firebase

class SetupViewController: UIViewController , UITextFieldDelegate{
    
    @IBOutlet var welcome: UILabel!
    @IBOutlet var invalidBusLabel: UILabel!
    @IBOutlet var intro: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var busNumLabel: UILabel!
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var startTracking: UIButton!
    @IBOutlet var addBus: UIButton!
    @IBOutlet var removeButton: UIButton!
    @IBOutlet var editBus: UIButton!
    @IBOutlet var goBack: UIButton!
    
    @IBAction func goBackTapped(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AppContainerViewController")
        self.present(secondViewController!, animated: true, completion: nil)
    }
    
    
    @IBAction func editBusTapped(_ sender: Any) {
        handleEdit()
    }
    
    @IBAction func startTrackingTapped(_ sender: UIButton) {
        handleSetup()
    }
    
    @IBAction func addBusTapped(_ sender: UIButton) {
        handleAdd()
    }
    
    @IBAction func removeBusTapped(_ sender: UIButton) {
        handleRemove()
    }
    
    let ref = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    var realBusList = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let busesRef = Database.database().reference().child("buses")
        busesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            for case let rest as DataSnapshot in snapshot.children {
                self.realBusList.append(Int(rest.key) ?? 0)
            }
        })
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
    
    func handleRemove(){
        guard let busNum = passwordField.text else{
            print("Form is not valid")
            return
        }
        let busRef = ref.child("buses").child("\(busNum)")
        if self.realBusList.contains(Int(busNum) ?? 0){
            busRef.removeValue()
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AppContainerViewController")
            self.present(secondViewController!, animated: true, completion: nil)
        } else{
            self.invalidBusLabel.isHidden = false
            return
        }
 
    }
    
    func handleEdit(){
        guard let busNum = passwordField.text else{
            print("Form is not valid")
            return
        }
        let usersRef = ref.child("users").child(userID!)
        let values = ["busNum": busNum]

        usersRef.updateChildValues(values) { (err, ref) in
            
            if err != nil || !self.realBusList.contains(Int(busNum) ?? 0){
                
                self.invalidBusLabel.isHidden = false
                return
            }
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AppContainerViewController")
            self.present(secondViewController!, animated: true, completion: nil)
            
        }
    }
    
    func handleAdd(){
        guard let busNum = passwordField.text else{
            print("Form is not valid")
            return
        }
        let busRef = ref.child("buses").child("\(busNum)")
        let values = ["location": "0"]
        busRef.updateChildValues(values) { (err, ref) in
            
            if err != nil || self.realBusList.contains(Int(busNum) ?? 0){
                
                self.invalidBusLabel.isHidden = false
                return
            }
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AppContainerViewController")
            self.present(secondViewController!, animated: true, completion: nil)
            
        }
    }
    
    func handleSetup() {
        guard let name = usernameField.text, let busNum = passwordField.text else{
            print("Form is not valid")
            return
        }
        let usersRef = ref.child("users").child(userID!)
        var values = ["busNum": busNum, "name": name, "isDone": "true"]
        usersRef.updateChildValues(values) { (err, ref) in
            
            if err != nil || !self.realBusList.contains(Int(busNum) ?? 0){
                
                self.invalidBusLabel.isHidden = false
                values = ["busNum": busNum, "name": name, "isDone": "false"]
                usersRef.updateChildValues(values) { (err, ref) in
                    if err != nil{
                        print(err!)
                        return
                    }
                }
                return
            }
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AppContainerViewController")
            self.present(secondViewController!, animated: true, completion: nil)
        }
    }
    
}
