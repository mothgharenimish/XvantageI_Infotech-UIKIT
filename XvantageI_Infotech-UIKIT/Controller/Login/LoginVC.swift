//
//  LoginVC.swift
//  XvantageI_Infotech-UIKIT
//
//  Created by Nimish Mothghare on 21/05/25.
//

import UIKit
import IQKeyboardManagerSwift

class LoginVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate,UserListDataPass{
   
    
    
    //MARK: -IBOutlet
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nametxtField: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailtxtField: UITextField!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phonenotxtField: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    
    let coredatamanager = CoreDataManager()
    
    var isEditMode = false
    var usertoEdit : LoginData?

    
    //MARK: -View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileImg.layer.cornerRadius = self.profileImg.frame.size.height / 2
        self.nameView.setCornerRadiusView(9.0)
        nameView.layer.borderWidth = 1.0
        nameView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.emailView.setCornerRadiusView(9.0)
        emailView.layer.borderWidth = 1.0
        emailView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.phoneView.setCornerRadiusView(9.0)
        phoneView.layer.borderWidth = 1.0
        phoneView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.saveBtn.setCornerRadiusBtn(9.0)
        
        
        self.profileImg.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        profileImg.addGestureRecognizer(tapGesture)
        
        
    }
    func userData(users: LoginData) {
        
        if isEditMode , let user = usertoEdit {
            self.nametxtField.text = user.name
            self.emailtxtField.text = user.email
            self.phonenotxtField.text = user.phonenumber
            self.profileImg.image =  UIImage(data: user.profileimg!)
            
            title = "Edit Order"
            
        }
        
        else {
            
            title = "Add the User"
        }
       
    }
    
    @objc func imageTapped() {
          let picker = UIImagePickerController()
          picker.delegate = self
          picker.sourceType = .photoLibrary
          picker.allowsEditing = true
          present(picker, animated: true, completion: nil)
      }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         
         if let editedImage = info[.editedImage] as? UIImage {
             profileImg.image = editedImage
         } else if let originalImage = info[.originalImage] as? UIImage {
             profileImg.image = originalImage
         }
         
         picker.dismiss(animated: true, completion: nil)
     }

     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         picker.dismiss(animated: true, completion: nil)
     }
    
    
    
    //MARK: Save IBAction
    @IBAction func saveAction(_ sender: UIButton) {
        
        
        guard let name = nametxtField.text, !name.isEmpty,
              let email = emailtxtField.text, !email.isEmpty,
              let phone = phonenotxtField.text,!phone.isEmpty,
              let profile = profileImg.image, !profile.isSymbolImage else {
              showAlert(message: "All the fields are required", title: "Sign In")
            return
        }
        
        if !isValidName(name) {
                showAlert(message: "Please enter a valid name (letters only)", title: "Validation Error")
                return
            }
            
            if !isValidEmail(email) {
                showAlert(message: "Please enter a valid email address", title: "Validation Error")
                return
            }
            
            if !isValidPhone(phone) {
                showAlert(message: "Please enter a valid 10-digit phone number", title: "Validation Error")
                return
            }
        
        
        if isEditMode {
            
            coredatamanager.updateUserData(user: usertoEdit!, newName: name, newEmail: email, newPhone: phone, newProfileImg: profile)
        }
        
        else {
            coredatamanager.SaveUserData(name: name, email: email, phoneno: phone, profileimg: profile, completion: { (success, message) in
                
                if success {
                    
                    let userdata = self.coredatamanager.fetchUserData()
                    
                    for user in userdata {
                        
                        print("Print the ussr data: \(user)")
                    }
                    
                } else {
                    
                    print("The User data is not there")
                }
                
            })
            
        }
             self.shownaviagtionAlert(title: "Sign In", message: "Data Successfully saved", completion: {
                 
                 let userViewController = self.storyboard!.instantiateViewController(withIdentifier: "UserListVC") as! UserListVC
                 userViewController.userdelegate = self
                 self.navigationController!.pushViewController(userViewController, animated: true)
                 
             })
             
            
            
       
            
    
        

        
        
        
    }
}
