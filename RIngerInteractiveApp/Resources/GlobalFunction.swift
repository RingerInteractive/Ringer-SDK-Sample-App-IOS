//
//  GlobalFunction.swift
//  RingerTest
//
//  Created by Hari Krishna on 17/02/22.
//

import Foundation
import UIKit

class GlobalFunction: NSObject {
    
    static var hub = ProgressHUD()
    
    static func showLoadingIndicator(title: String = "") {
        
        hub = ProgressHUD.show(addedToView: (UIApplication.shared.windows.first)!, animated: true)
        
        hub.contentColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
        
        if title != "" {
            hub.label?.text = title
        }
        
        UIApplication.shared.windows.first?.isUserInteractionEnabled = false
    }
    
    static func hideLoadingIndicator() {
        hub.hide(animated: true)
        UIApplication.shared.windows.first?.isUserInteractionEnabled = true
    }
    
    static var keyDev = "cmluZ2VyZGV2M0BnbWFpbC5jb206cmluZ2VyZGV2MjAyMw=="
    static var urlDev = "https://dev-1.ringerid.com/api/"
    static var keyProd = "dGltQGJhc2Fsc21hcnRzb2x1dGlvbnMuY29tOlJpbmdjIyMxMjM0"
    static var urlProd = "https://sandbox.thrio.io/"
}
