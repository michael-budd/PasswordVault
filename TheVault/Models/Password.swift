//
//  Password.swift
//  TheVault
//
//  Created by Michael Budd on 12/9/17.
//  Copyright © 2017 Michael Budd. All rights reserved.
//

import Foundation
import CloudKit


class Password {
    
    private let websiteKey = "website"
    private let usernameKey = "username"
    private let secretKey = "secret"
    
    let website: String
    let username: String
    let secret: String
    
    init(website: String, username: String, secret: String) {
        self.website = website
        self.username = username
        self.secret = secret
    }
    
    init?(cloudKitRecord: CKRecord) {
        guard let website = cloudKitRecord[websiteKey] as? String,
            let username = cloudKitRecord[usernameKey] as? String,
            let secret = cloudKitRecord[secretKey] as? String else { return nil }
        self.website = website
        self.username = username
        self.secret = secret
    }
    
}








