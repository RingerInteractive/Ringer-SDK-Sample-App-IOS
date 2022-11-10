import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    @IBAction func btnPrivacyPolicyAction(_ sender: UIButton) {
        let url = URL(string: "https://ringerinteractive.com/privacy-policy/")!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            //If you want handle the completion block than
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                 print("Open url : \(success)")
            })
        }
    }
    
    @IBAction func btnTermsServiceAction(_ sender: UIButton) {
        let url = URL(string: "https://ringerinteractive.com/terms-and-conditions/")!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            //If you want handle the completion block than
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                 print("Open url : \(success)")
            })
        }
    }

}
