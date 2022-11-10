import UIKit
import SwiftUI

class TermsAndConditionVC: UIViewController {

    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var btnAcceptTermsAndCondition: UIButton!
    @IBOutlet weak var btnCheckBox: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: Button Action
extension TermsAndConditionVC {
    @IBAction func btnAction(_ sender: UIButton) {
        switch sender {
        case btnContinue :
            if self.btnCheckBox.isSelected {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContactListVC") as! ContactListVC
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.alertbox(title: "RingerInteractive", message: "Please accept the terms and condition.")
            }
        case btnCheckBox :
            print("btnCheckBox")
        case btnAcceptTermsAndCondition :
            self.btnCheckBox.isSelected = self.btnCheckBox.isSelected ? false : true
        default :
            print("default")
        }
    }
}
