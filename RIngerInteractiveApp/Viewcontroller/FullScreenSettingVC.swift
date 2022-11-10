import UIKit
import Contacts

class FullScreenSettingVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnOpenSettingsAction(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.showSettingsAlert()
        }
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension FullScreenSettingVC {
    
    func showSettingsAlert() {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            DispatchQueue.main.async {
                if let settings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(settings) {
                    UIApplication.shared.open(settings)
                }
            }
        case .denied:
            DispatchQueue.main.async {
                let alert = UIAlertController(title: nil, message: "Please enable your Phone setting to Full Screen so the app displays images for incoming calls.", preferredStyle: .alert)
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
        case .restricted, .notDetermined:
            CNContactStore().requestAccess(for: .contacts) { granted, error in
                if granted {
                    DispatchQueue.main.async {
                        if let settings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(settings) {
                            UIApplication.shared.open(settings)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: nil, message: "Please enable your Phone setting to Full Screen so the app displays images for incoming calls.", preferredStyle: .alert)
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
            }
        @unknown default:
            print("Default")
        }
    }
}
