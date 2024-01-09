import UIKit
import Contacts
import ContactsUI
import FirebaseCore
import FirebaseAuth
import FirebaseMessaging
import Ringer_Interactive

class PermissionVC: BaseViewController, UNUserNotificationCenterDelegate, MessagingDelegate {

    @IBOutlet weak var nslcSpace: NSLayoutConstraint!
    @IBOutlet weak var nslcTypeHeight: NSLayoutConstraint!
    @IBOutlet weak var btnProcess: UIButton!
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgTypeIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if usNotification {
            if usContact {
                if !TermsCondition {
                    DispatchQueue.main.async {
                        self.btnProcess.setTitle("Accept Terms", for: .normal)
                        self.lblTitle.text = "Terms & Conditions"
                        self.nslcTypeHeight.constant = 0.0
                        self.nslcSpace.constant = 0.0
                        self.lblMsg.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.btnProcess.setTitle("Continue", for: .normal)
                    self.lblTitle.text = "Access to Contacts"
                    self.imgTypeIcon.image = UIImage(named: "Icon_1")
                    self.nslcTypeHeight.constant = 100.0
                    self.nslcSpace.constant = 30.0
                    self.lblMsg.text = """
                        Ringer needs access to your contacts in order to provide full functionality. We do not share your contacts with any 3rd parties, and we do not store your contacts in our database.
                        
                           Note: Ringer will not function properly if access to contacts is not allowed.
                        """
                }
            }
        } else {
            DispatchQueue.main.async {
                self.btnProcess.setTitle("Continue", for: .normal)
                self.lblTitle.text = "Notifications"
                self.imgTypeIcon.image = UIImage(named: "Icon_11")
                self.nslcTypeHeight.constant = 100.0
                self.nslcSpace.constant = 30.0
                self.lblMsg.text = """
            Enabling push notifications is an important function of Ringer.
            
            Note: Ringer may not function properly if notifications are disabled.
            """
            }
        }
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
    
        if self.lblTitle.text == "Notifications" {
            UserDefaults.standard.set(true, forKey: "Notification")
            self.registerForRemoteNotifications()
            
        } else if self.lblTitle.text == "Access to Contacts" {
            UserDefaults.standard.set(true, forKey: "Contact")
            self.requestAccess()
        } else  {
            UserDefaults.standard.set(true, forKey: "Condition")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    public func requestAccess() {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            DispatchQueue.main.async {
                self.btnProcess.setTitle("Accept Terms", for: .normal)
                self.lblTitle.text = "Terms & Conditions"
                self.nslcTypeHeight.constant = 0.0
                self.nslcSpace.constant = 0.0
                self.lblMsg.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
                
                UserDefaults.standard.set(true, forKey: "Condition")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
       
            
        case .denied:
            DispatchQueue.main.async {
                self.btnProcess.setTitle("Accept Terms", for: .normal)
                self.lblTitle.text = "Terms & Conditions"
                self.nslcTypeHeight.constant = 0.0
                self.nslcSpace.constant = 0.0
                self.lblMsg.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
                
                UserDefaults.standard.set(true, forKey: "Condition")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
          
        case .restricted, .notDetermined:
            CNContactStore().requestAccess(for: .contacts) { granted, error in
                if granted {
                    DispatchQueue.main.async {
                        self.btnProcess.setTitle("Accept Terms", for: .normal)
                        self.lblTitle.text = "Terms & Conditions"
                        self.nslcTypeHeight.constant = 0.0
                        self.nslcSpace.constant = 0.0
                        self.lblMsg.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
                        
                        UserDefaults.standard.set(true, forKey: "Condition")
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                   
                    
                } else {
                    DispatchQueue.main.async {
                        self.btnProcess.setTitle("Accept Terms", for: .normal)
                        self.lblTitle.text = "Terms & Conditions"
                        self.nslcTypeHeight.constant = 0.0
                        self.nslcSpace.constant = 0.0
                        self.lblMsg.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
                        
                        UserDefaults.standard.set(true, forKey: "Condition")
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                   
                    
                }
            }
        @unknown default:
            print("Default")
        }
    }
    func showSettingsAlert() {
        let alert = UIAlertController(title: nil, message: "This app requires access to Contacts to proceed. Go to Settings to grant access.", preferredStyle: .alert)
        if
            let settings = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(settings) {
            alert.addAction(UIAlertAction(title: "Settings", style: .default) { action in
                UIApplication.shared.open(settings)
            })
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { action in
        })
        let topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
        topWindow?.rootViewController = UIViewController()
        topWindow?.windowLevel = UIWindow.Level.alert + 1
        topWindow?.makeKeyAndVisible()
        topWindow?.rootViewController?.present(alert, animated: true)
    }
    func registerForRemoteNotifications() {
//        Messaging.messaging().delegate = /*self*/
        if #available(iOS 10.0, *) {
//            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in
                    DispatchQueue.main.async {
                        self.btnProcess.setTitle("Continue", for: .normal)
                        self.lblTitle.text = "Access to Contacts"
                        self.imgTypeIcon.image = UIImage(named: "Icon_1")
                        self.nslcTypeHeight.constant = 100.0
                        self.nslcSpace.constant = 30.0
                        self.lblMsg.text = """
                        Ringer needs access to your contacts in order to provide full functionality. We do not share your contacts with any 3rd parties, and we do not store your contacts in our database.
                        
                           Note: Ringer will not function properly if access to contacts is not allowed.
                        """

                    }
                })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
}
