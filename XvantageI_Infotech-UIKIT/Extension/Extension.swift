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
    
    
    func isValidName(_ name: String) -> Bool {
        let nameRegex = "^[A-Za-z ]{2,}$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return namePredicate.evaluate(with: name)
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    func isValidPhone(_ phone: String) -> Bool {
        let phoneRegex = "^[6-9]\\d{9}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: phone)
    }

    
    
    
}


extension UIView {
    
    func setCornerRadiusView(_ radius: CGFloat) {
           self.layer.cornerRadius = radius
       }
    
}


extension UIButton {
    
    
    func setCornerRadiusBtn(_ radius: CGFloat) {
           self.layer.cornerRadius = radius
       }
    
}
