//
//  Extension.swift
//  XvantageI_Infotech-UIKIT
//
//  Created by Nimish Mothghare on 22/05/25.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(message: String,title : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func shownaviagtionAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}
