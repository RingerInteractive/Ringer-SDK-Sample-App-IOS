import UIKit

class PhoneNumberVC: BaseViewController {

    @IBOutlet weak var txtPhoneNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        if txtPhoneNumber.text != "" {
            txtPhoneNumber.resignFirstResponder()
            if txtPhoneNumber.text?.count == 13 {
                UserDefaults.standard.set(true, forKey: "PhoneNumber")
                let number = txtPhoneNumber.text?.components(separatedBy:CharacterSet.decimalDigits.inverted).joined()
                UserDefaults.standard.set(number, forKey: "userPhoneNumber")
                UserDefaults.standard.synchronize()
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "PermissionVC") as! PermissionVC
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let alert = UIAlertController(title: "Ringer", message: "Please enter valid phone number", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Ringer", message: "Please enter phone number", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtPhoneNumber {
            guard let text = textField.text else { return false }
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = format(with: "(XXX)XXX-XXXX", phone: newString)
            return false
        } else {
            return true
        }
    }
    
    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator

        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])

                // move numbers iterator to the next index
                index = numbers.index(after: index)

            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
}
