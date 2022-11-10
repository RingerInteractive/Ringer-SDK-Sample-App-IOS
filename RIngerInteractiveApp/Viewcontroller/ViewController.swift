import UIKit
import Contacts
import ContactsUI

var usNotification : Bool = false
var usContact : Bool = false
var TermsCondition : Bool = false
var phoneNumber: Bool = false

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TermsCondition = UserDefaults.standard.bool(forKey: "Condition")
        usNotification = UserDefaults.standard.bool(forKey: "Notification")
        usContact = UserDefaults.standard.bool(forKey: "Contact")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if usNotification && usContact && TermsCondition {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "PermissionVC") as! PermissionVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
}

