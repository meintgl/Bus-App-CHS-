//
//  MapViewController.swift
//  BusAppDevelopment
//
//  Created by Bishrut Bhattarai on 11/19/19.
//  Copyright © 2019 Meinhard Benedict Capucao. All rights reserved.
//

import UIKit
import Firebase

class MapViewController: UIViewController, UITextFieldDelegate{

    
    let userID = Auth.auth().currentUser?.uid
    
    //Circular icon behind stars / bus correspondence
    @IBOutlet var logout: UIButton!
    @IBOutlet var purple: UIImageView!
    @IBOutlet var blue: UIImageView!
    @IBOutlet var green: UIImageView!
    @IBOutlet var yellow: UIImageView!
    @IBOutlet var orange: UIImageView!
    @IBOutlet var red: UIImageView!
    
    //Bus Status Label in bottom side of the screen
    @IBOutlet var busStatus: UILabel!

    //Type Bus Number instruction
    @IBOutlet var instructions1: UILabel!
    
    //Please remove bus (admin function)
    @IBOutlet var instructions2: UILabel!
    
    //Bus 1
    @IBOutlet var field1: UITextField!
    @IBOutlet var enter1: UIButton!
    
    
    @IBOutlet var busLabel1: UILabel!
    @IBOutlet var return1: UIButton!
    
    //Bus 2
    @IBOutlet var field2: UITextField!
    @IBOutlet var enter2: UIButton!
    @IBOutlet var busLabel2: UILabel!
    @IBOutlet var remove2: UIButton!
    
    //Bus 3
    @IBOutlet var field3: UITextField!
    @IBOutlet var enter3: UIButton!
    @IBOutlet var busLabel3: UILabel!
    @IBOutlet var remove3: UIButton!
    
    //Bus 4
    @IBOutlet var field4: UITextField!
    @IBOutlet var enter4: UIButton!
    @IBOutlet var busLabel4: UILabel!
    @IBOutlet var remove4: UIButton!
    
    //Bus 5
    @IBOutlet var field5: UITextField!
    @IBOutlet var enter5: UIButton!
    @IBOutlet var busLabel5: UILabel!
    @IBOutlet var remove5: UIButton!
    
    //Bus 6
    @IBOutlet var field6: UITextField!
    @IBOutlet var enter6: UIButton!
    @IBOutlet var busLabel6: UILabel!
    @IBOutlet var remove6: UIButton!
    
    var name = ""
    var busNum = 0
    
    var isAdmin = true
    var isDone = false
    var busLoc = 0
    
    var busList = [[Int]]()
    var realBusList = [Int]()
    var activeBusList = [Int]()
    @IBOutlet var reset: UIButton!
    
    
    
    let ref = Database.database().reference()
    
    @IBAction func resetPressed(_ sender: Any) {
        for number in realBusList{
            let newRef = ref.child("buses").child("\(number)")
            newRef.updateChildValues(["location": "0"])
        }
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        AppManager.shared.logOut()
    }
    
    
    @IBAction func enter1Pressed(_ sender: Any) {
        busStatus.isHidden = true
        let num = Int(field1.text ?? "0") ?? 0
        if busList.contains([num, 0]) && !activeBusList.contains(num){
            let newRef = ref.child("buses").child("\(num)")
            newRef.updateChildValues(["location": "1"])
            field1.text = "Bus #"
        } else {
            busStatus.isHidden = false
            busStatus.text = "Please enter a valid bus number."
        }
    }
    
    @IBAction func enter2Pressed(_ sender: Any) {
        busStatus.isHidden = true
        let num = Int(field2.text ?? "0") ?? 0
        if busList.contains([num, 0]) && !activeBusList.contains(num){
            let newRef = ref.child("buses").child("\(num)")
            newRef.updateChildValues(["location": "2"])
            field2.text = "Bus #"
        } else {
            busStatus.isHidden = false
            busStatus.text = "Please enter a valid bus number."
        }
    }
    
    @IBAction func enter3Pressed(_ sender: Any) {
        busStatus.isHidden = true
        let num = Int(field3.text ?? "0") ?? 0
        if busList.contains([num, 0]) && !activeBusList.contains(num){
            let newRef = ref.child("buses").child("\(num)")
            newRef.updateChildValues(["location": "3"])
            field3.text = "Bus #"
        } else {
            busStatus.isHidden = false
            busStatus.text = "Please enter a valid bus number."
        }
    }
    
    @IBAction func enter4Pressed(_ sender: Any) {
        busStatus.isHidden = true
        let num = Int(field4.text ?? "0") ?? 0
        if busList.contains([num, 0]) && !activeBusList.contains(num){
            let newRef = ref.child("buses").child("\(num)")
            newRef.updateChildValues(["location": "4"])
            field4.text = "Bus #"
        } else {
            busStatus.isHidden = false
            busStatus.text = "Please enter a valid bus number."
        }
    }
    
    @IBAction func enter5Pressed(_ sender: Any) {
        busStatus.isHidden = true
        let num = Int(field5.text ?? "0") ?? 0
        if busList.contains([num, 0]) && !activeBusList.contains(num){
            let newRef = ref.child("buses").child("\(num)")
            newRef.updateChildValues(["location": "5"])
            field5.text = "Bus #"
        } else {
            busStatus.isHidden = false
            busStatus.text = "Please enter a valid bus number."
        }
    }
    
    @IBAction func enter6Pressed(_ sender: Any) {
        busStatus.isHidden = true
        let num = Int(field6.text ?? "0") ?? 0
        if busList.contains([num, 0]) && !activeBusList.contains(num){
            let newRef = ref.child("buses").child("\(num)")
            newRef.updateChildValues(["location": "6"])
            field6.text = "Bus #"
        } else {
            busStatus.isHidden = false
            busStatus.text = "Please enter a valid bus number."
        }
    }
    
    @IBAction func return1Pressed(_ sender: Any) {
        let newRef = ref.child("buses").child(busLabel1.text ?? "")
        newRef.updateChildValues(["location": "7"])
    }
    
    @IBAction func remove2Pressed(_ sender: Any) {
        let newRef = ref.child("buses").child(busLabel2.text ?? "")
        newRef.updateChildValues(["location": "7"])
    }
    
    @IBAction func remove3Pressed(_ sender: Any) {
        let newRef = ref.child("buses").child(busLabel3.text ?? "")
        newRef.updateChildValues(["location": "7"])
    }
    
    @IBAction func remove4Pressed(_ sender: Any) {
        let newRef = ref.child("buses").child(busLabel4.text ?? "")
        newRef.updateChildValues(["location": "7"])
    }
    
    @IBAction func remove5Pressed(_ sender: Any) {
        let newRef = ref.child("buses").child(busLabel5.text ?? "")
        newRef.updateChildValues(["location": "7"])
    }
    
    @IBAction func remove6Pressed(_ sender: Any) {
        let newRef = ref.child("buses").child(busLabel6.text ?? "")
        newRef.updateChildValues(["location": "7"])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        field1.delegate = self
        field2.delegate = self
        field3.delegate = self
        field4.delegate = self
        field5.delegate = self
        field6.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        userInfo()
        
        enter1.layer.borderColor = UIColor.black.cgColor
        enter1.layer.borderWidth = 1
        
        enter2.layer.borderColor = UIColor.black.cgColor
        enter2.layer.borderWidth = 1
        
        enter3.layer.borderColor = UIColor.black.cgColor
        enter3.layer.borderWidth = 1
        
        enter4.layer.borderColor = UIColor.black.cgColor
        enter4.layer.borderWidth = 1
        
        enter5.layer.borderColor = UIColor.black.cgColor
        enter5.layer.borderWidth = 1
        
        
        enter6.layer.borderColor = UIColor.black.cgColor
        enter6.layer.borderWidth = 1
        
        field1.layer.borderColor = UIColor.black.cgColor
        field1.layer.borderWidth = 1
        
        field2.layer.borderColor = UIColor.black.cgColor
        field2.layer.borderWidth = 1
        
        field3.layer.borderColor = UIColor.black.cgColor
        field3.layer.borderWidth = 1
        
        field4.layer.borderColor = UIColor.black.cgColor
        field4.layer.borderWidth = 1
        
        field5.layer.borderColor = UIColor.black.cgColor
        field5.layer.borderWidth = 1
        
        
        field6.layer.borderColor = UIColor.black.cgColor
        field6.layer.borderWidth = 1
    }
    
    func userInfo(){
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.name = value?["name"] as? String ?? ""
            self.busNum = Int(value?["busNum"] as? String ?? "") ?? 0
            self.isAdmin = Bool(value?["isAdmin"] as? String ?? "") ?? false
            self.isDone = Bool(value?["isDone"] as? String ?? "") ?? false
            if !self.isDone{
                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "Setup")
                self.present(secondViewController!, animated: true, completion: nil)
            }
            if !self.isAdmin{
                self.observeBus()
            } else{
                self.manageBus()
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func manageBus(){
        reset.isHidden = false
        instructions1.isHidden = false
        instructions2.isHidden = false
        field1.isHidden = false
        enter1.isHidden = false
        field2.isHidden = false
        enter2.isHidden = false
        field3.isHidden = false
        enter3.isHidden = false
        field4.isHidden = false
        enter4.isHidden = false
        field5.isHidden = false
        enter5.isHidden = false
        field6.isHidden = false
        enter6.isHidden = false
        let busesRef = Database.database().reference().child("buses")
        busesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            for case let rest as DataSnapshot in snapshot.children {
                let val = rest.value as? NSDictionary
                let valLoc = Int(val?["location"] as? String ?? "") ?? 0
                self.realBusList.append(Int(rest.key) ?? 0)
                self.busList.append([Int(rest.key) ?? 0, valLoc])
                if valLoc != 0 && valLoc != 7{
                    self.activeBusList.append(Int(rest.key) ?? 0)
                }
            }
        })
        busesRef.observe(.value, with: { snapshot in
            let postDict = snapshot.value as? NSDictionary
            for number in self.realBusList{
                let postDicts = postDict?["\(number)"] as? NSDictionary
                let postDictInt = Int(postDicts?["location"] as? String ?? "") ?? 0
                switch postDictInt{
                case 1:
                    self.field1.isHidden = true
                    self.enter1.isHidden = true
                    self.return1.isHidden = false
                    self.busLabel1.text = "\(number)"
                    self.busLabel1.isHidden = false
                    if let i = self.busList.firstIndex(of: [number, 0]){
                        self.busList[i] = [number, 1]
                        self.activeBusList.append(number)
                    }
                case 2:
                    self.field2.isHidden = true
                    self.enter2.isHidden = true
                    self.remove2.isHidden = false
                    self.busLabel2.text = "\(number)"
                    self.busLabel2.isHidden = false
                    if let i = self.busList.firstIndex(of: [number, 0]){
                        self.busList[i] = [number, 2]
                        self.activeBusList.append(number)
                    }
                case 3:
                    self.field3.isHidden = true
                    self.enter3.isHidden = true
                    self.remove3.isHidden = false
                    self.busLabel3.text = "\(number)"
                    self.busLabel3.isHidden = false
                    if let i = self.busList.firstIndex(of: [number, 0]){
                        self.busList[i] = [number, 3]
                        self.activeBusList.append(number)
                    }
                case 4:
                    self.field4.isHidden = true
                    self.enter4.isHidden = true
                    self.remove4.isHidden = false
                    self.busLabel4.text = "\(number)"
                    self.busLabel4.isHidden = false
                    if let i = self.busList.firstIndex(of: [number, 0]){
                        self.busList[i] = [number, 4]
                        self.activeBusList.append(number)
                    }
                case 5:
                    self.field5.isHidden = true
                    self.enter5.isHidden = true
                    self.remove5.isHidden = false
                    self.busLabel5.text = "\(number)"
                    self.busLabel5.isHidden = false
                    if let i = self.busList.firstIndex(of: [number, 0]){
                        self.busList[i] = [number, 5]
                        self.activeBusList.append(number)
                    }
                case 6:
                    self.field6.isHidden = true
                    self.enter6.isHidden = true
                    self.remove6.isHidden = false
                    self.busLabel6.text = "\(number)"
                    self.busLabel6.isHidden = false
                    if let i = self.busList.firstIndex(of: [number, 0]){
                        self.busList[i] = [number, 6]
                        self.activeBusList.append(number)
                    }
                case 7:
                    for i in 1...6{
                        if let j = self.busList.firstIndex(of: [number, i]){
                            switch i{
                            case 1:
                                self.return1.isHidden = true
                                self.busLabel1.isHidden = true
                                self.enter1.isHidden = false
                                self.field1.isHidden = false
                            case 2:
                                self.remove2.isHidden = true
                                self.busLabel2.isHidden = true
                                self.enter2.isHidden = false
                                self.field2.isHidden = false
                            case 3:
                                self.remove3.isHidden = true
                                self.busLabel3.isHidden = true
                                self.enter3.isHidden = false
                                self.field3.isHidden = false
                            case 4:
                                self.remove4.isHidden = true
                                self.busLabel4.isHidden = true
                                self.enter4.isHidden = false
                                self.field4.isHidden = false
                            case 5:
                                self.remove5.isHidden = true
                                self.busLabel5.isHidden = true
                                self.enter5.isHidden = false
                                self.field5.isHidden = false
                            default:
                                self.remove6.isHidden = true
                                self.busLabel6.isHidden = true
                                self.enter6.isHidden = false
                                self.field6.isHidden = false
                            }
                            self.busList[j] = [number, 7]
                            if let index = self.activeBusList.firstIndex(of: number){
                                self.activeBusList.remove(at: index)
                            }
                        }
                    }
                default:
                    for i in 1...7{
                        if let j = self.busList.firstIndex(of: [number, i]){
                            switch i{
                            case 1:
                                self.return1.isHidden = true
                                self.busLabel1.isHidden = true
                                self.enter1.isHidden = false
                                self.field1.isHidden = false
                            case 2:
                                self.remove2.isHidden = true
                                self.busLabel2.isHidden = true
                                self.enter2.isHidden = false
                                self.field2.isHidden = false
                            case 3:
                                self.remove3.isHidden = true
                                self.busLabel3.isHidden = true
                                self.enter3.isHidden = false
                                self.field3.isHidden = false
                            case 4:
                                self.remove4.isHidden = true
                                self.busLabel4.isHidden = true
                                self.enter4.isHidden = false
                                self.field4.isHidden = false
                            case 5:
                                self.remove5.isHidden = true
                                self.busLabel5.isHidden = true
                                self.enter5.isHidden = false
                                self.field5.isHidden = false
                            case 6:
                                self.remove6.isHidden = true
                                self.busLabel6.isHidden = true
                                self.enter6.isHidden = false
                                self.field6.isHidden = false
                            default:
                                print("")
                            }
                            self.busList[j] = [number, 0]
                            if let index = self.activeBusList.firstIndex(of: number){
                                self.activeBusList.remove(at: index)
                            }
                        }
                    }
                }
            }
        })
    }
    
    
    func observeBus(){
        self.busStatus.isHidden = false
        let busRef = Database.database().reference().child("buses").child("\(self.busNum)")
        busRef.observe(.value, with: { snapshot in
            let postDict = snapshot.value as? [String: Any]
            self.busLoc = Int(postDict?["location"] as? String ?? "") ?? 0
            self.purple.isHidden = true
            self.blue.isHidden = true
            self.green.isHidden = true
            self.yellow.isHidden = true
            self.orange.isHidden = true
            self.red.isHidden = true
            switch self.busLoc{
            case 0:
                self.busStatus.text = "Your bus is on the way!"
                
            
            case 1:
                self.purple.isHidden = false
                self.busStatus.text = "Your bus is in the purple zone."
            case 2:
                self.blue.isHidden = false
                self.busStatus.text = "Your bus is in the blue zone."
            case 3:
                self.green.isHidden = false
                self.busStatus.text = "Your bus is in the green zone."
            case 4:
                self.yellow.isHidden = false
                self.busStatus.text = "Your bus is in the yellow zone."
            case 5:
                self.orange.isHidden = false
                self.busStatus.text = "Your bus is in the orange zone."
            case 6:
                self.red.isHidden = false
                self.busStatus.text = "Your bus is in the red zone."
            default:
                self.busStatus.text = "Your bus has already left."
            }
        })
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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }


}
