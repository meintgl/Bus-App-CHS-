import UIKit
import Firebase

class AppManager{
    
    static let shared = AppManager()
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var appContainer: AppContainerViewController!
    var bol = true
    
    private init (){
        
    }
    
    func showApp(){
        var viewController: UIViewController
        if Auth.auth().currentUser == nil{
            viewController = storyboard.instantiateViewController(withIdentifier: "Login")
        } else {
            viewController = self.storyboard.instantiateViewController(withIdentifier: "Main")
            }
        appContainer.present(viewController, animated: true, completion: nil)
    }
    
    func checkForChildren(){
        let userID = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.bol = Bool(value?["isDone"] as? String ?? "") ?? false
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func logOut(){
        try! Auth.auth().signOut()
        appContainer.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
}
