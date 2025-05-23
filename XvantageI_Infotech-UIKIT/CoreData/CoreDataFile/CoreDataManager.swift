//
//  CoreDataManager.swift
//  XvantageI_Infotech-UIKIT
//
//  Created by Nimish Mothghare on 21/05/25.
//

import Foundation
import CoreData
import UIKit


class CoreDataManager {
    
    
    // MARK: - Core Data context
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var context: NSManagedObjectContext!
    
    init() {
        context = appDelegate.persistentContainer.viewContext
    }
    
    
    func SaveUserData(name : String,email : String, phoneno : String,profileimg : UIImage?, completion: @escaping (Bool, String) -> Void) {
        
        let user = LoginData(context: context)
        print(user)
        user.name = name
        user.email = email
        user.phonenumber = phoneno
        
        
        if let imageData = profileimg {
            
            if let pngImage = imageData.pngData() {
                
                user.profileimg = pngImage
            }
            
            else if let jpgimage = imageData.jpegData(compressionQuality: 0.1) {
                
                user.profileimg = jpgimage
            }
        }
        
        
        do {
            try context.save()
            completion(true, "User Data Successfully saved")
        } catch {
            print("Failed to save data: \(error)")
            completion(false, "An error occurred while saving user data.")
        }
        
    }
    
    
    func fetchUserData() -> [LoginData] {
            let request: NSFetchRequest<LoginData> = LoginData.fetchRequest()
            do {
                return try context.fetch(request)
            } catch {
                print("Failed to fetch users: \(error)")
                return []
            }
        }
    
    
       func updateUserData(user: LoginData, newName: String, newEmail: String, newPhone: String, newProfileImg: UIImage?) {
           user.name = newName
           user.email = newEmail
           user.phonenumber = newPhone
           
           if let imageData = newProfileImg {
               if let pngImage = imageData.pngData() {
                   user.profileimg = pngImage
               } else if let jpgImage = imageData.jpegData(compressionQuality: 0.1) {
                   user.profileimg = jpgImage
               }
           }
           
           do {
               try context.save()
//               completion(true, "User data updated successfully.")
           } catch {
               print("Failed to update user: \(error)")
//               completion(false, "An error occurred while updating user data.")
           }
       }
       
       func deleteUserData(user: LoginData) {
           context.delete(user)
           do {
               try context.save()
//               completion(true, "User deleted successfully.")
           } catch {
               print("Failed to delete user: \(error)")
//               completion(false, "An error occurred while deleting user.")
           }
       }
    
}
