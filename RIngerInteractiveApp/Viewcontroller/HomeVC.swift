import UIKit
import Ringer_Interactive
//import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseMessaging
import Contacts
import ContactsUI

class HomeVC: BaseViewController, DrawerControllerDelegate {
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var usContact: UISwitch!
    @IBOutlet weak var usNotification: UISwitch!
    
    var temp: RingerInteractiveNotification? = nil
    var drawerVw = DrawerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        temp = (UIApplication.shared.delegate as? AppDelegate)?.temp
        temp?.notificationRegister()
        Messaging.messaging().token { [weak self] token, error in
            guard let strongSelf = self else {return}
            if let error = error {
                print(error)
            } else if let token = token {
                strongSelf.temp?.setFireBaseToken(fcmToken: token)
            }
        }
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let current = UNUserNotificationCenter.current()
        
        current.getNotificationSettings(completionHandler: { permission in
            DispatchQueue.main.async {
                switch permission.authorizationStatus  {
                case .authorized:
                    self.usNotification.isOn = true
                case .denied:
                    self.usNotification.isOn = false
                case .notDetermined:
                    self.usNotification.isOn = false
                case .provisional:
                    // @available(iOS 12.0, *)
                    self.usNotification.isOn = false
                case .ephemeral:
                    // @available(iOS 14.0, *)
                    self.usNotification.isOn = false
                @unknown default:
                    print("Unknow Status")
                }
            }
        })
        
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            DispatchQueue.main.async {
                self.usContact.isOn = true
            }
        case .denied:
            DispatchQueue.main.async {
                self.usContact.isOn = false
            }
        case .restricted, .notDetermined:
            CNContactStore().requestAccess(for: .contacts) { granted, error in
                if granted {
                    DispatchQueue.main.async {
                        self.usContact.isOn = true
                    }
                } else {
                    DispatchQueue.main.async {
                        self.usContact.isOn = false
                    }
                }
            }
        @unknown default:
            print("Default")
        }
    }
    
    
    @IBAction func btnContactUsAction(_ sender: UIButton) {
        let appURL = URL(string: "mailto:info@flashappllc.com")!
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(appURL)
        }
    }
    
    @IBAction func btnMenuAction(_ sender: UIButton) {
        
        drawerVw = DrawerView(isBlurEffect:false, controller:self)
        drawerVw.delegate = self
        drawerVw.show()
    }
    
    func pushTo(indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsUrl)
                    
                }
            } else if indexPath.row == 1 {
                if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsUrl)
                }
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                let url = URL(string: "https://ringerinteractive.com/privacy-policy/")!
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    //If you want handle the completion block than
                    UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                    })
                }
            } else if indexPath.row == 1 {
                let url = URL(string: "https://ringerinteractive.com/terms-and-conditions/")!
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    //If you want handle the completion block than
                    UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                        
                    })
                }
            } else if indexPath.row == 2 {
                let appURL = URL(string: "https://ringerinteractive.com/eula/")!
                
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(appURL)
                }
            }
        } else if indexPath.section == 2 {
            let appURL = URL(string: "mailto:info@flashappllc.com")!
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(appURL)
            }
        }
    }
    
    @IBAction func usAction(_ sender: UISwitch) {
        if sender == usContact {
        } else {
        }
    }
    
    @IBAction func btnEditSettingAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FullScreenSettingVC") as! FullScreenSettingVC
        self.navigationController?.pushViewController(vc, animated: true)
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
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
}
