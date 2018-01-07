//
//  PasswordController.swift
//  TheVault
//
//  Created by Michael Budd on 12/9/17.
//  Copyright © 2017 Michael Budd. All rights reserved.
//

import Foundation
import CloudKit

class PasswordController {
    
    static let shared = PasswordController()
    
    let database = CKContainer.default().privateCloudDatabase
    
    func saveToCloud(password: Password) {
        
        let newPassword = CKRecord(recordType: "Password")
        
        newPassword.setValue(password.website, forKey: "website")
        newPassword.setValue(password.username, forKey: "username")
        newPassword.setValue(password.secret, forKey: "secret")
        
        database.save(newPassword) { (record, error) in
            if let error = error {
                NSLog("Error saving to CloudKit: \(error), \(error.localizedDescription) ")
            }
            guard record != nil else { return }
            NSLog("Saved password as record in CloudKit.)")
        }
        
    }
    
    func queryDatabase(completion: @escaping ([Password]?) -> Void ) {

        let query = CKQuery(recordType: "Password", predicate: NSPredicate(value: true))
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                NSLog("Error performing query. \(error): \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let records = records else { return }
            
            let arrayOfPasswords = records.flatMap{ Password(cloudKitRecord: $0) }
            completion(arrayOfPasswords)
            
        }
    
    }
    
}











