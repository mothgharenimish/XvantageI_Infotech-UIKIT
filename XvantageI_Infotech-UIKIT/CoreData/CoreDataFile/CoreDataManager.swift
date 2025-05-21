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
    
    
    
    
    
}
