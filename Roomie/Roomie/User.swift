//
//  User.swift
//  Roomie
//
//  Created by Alex Aslett on 9/20/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import Foundation
import CloudKit

class User {
    
    static let firstNameKey = "firstName"
    static let lastNameKey = "lastName"
    static let emailKey = "email"
    static let phoneKey = "phone"
    static let groupsRefsKey = "groupsRefs"
    static let appleUserRefKey = "appleUserRef"
    static let recordTypeKey = "User"
    
    //FIXME: Need to make the group ID an array of CKRefrences 
    
    var firstName: String
    var lastName: String
    var email: String
    var phone: String?
    var groupsRefs: [CKReference]
    
    let appleUserRef: CKReference
    
    var cloudKitRecordID: CKRecordID?
    
    init(firstName: String, lastName: String, email: String, phone: String?, groupsRefs: [CKReference] = [], appleUserRef: CKReference){
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
        self.groupsRefs = groupsRefs
        self.appleUserRef = appleUserRef
    }
    
    init?(cloudKitRecord: CKRecord) {
        guard cloudKitRecord.recordType == User.recordTypeKey,
            let firstName = cloudKitRecord[User.firstNameKey] as? String,
            let lastName = cloudKitRecord[User.lastNameKey] as? String,
            let email = cloudKitRecord[User.emailKey] as? String,
            let phone = cloudKitRecord[User.phoneKey] as? String,
            let appleUserRef = cloudKitRecord[User.appleUserRefKey] as? CKReference else { return nil }
        
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
        self.groupsRefs = cloudKitRecord[User.groupsRefsKey] as? [CKReference] ?? []
        self.appleUserRef = appleUserRef
        self.cloudKitRecordID = cloudKitRecord.recordID
        
    }
}

extension CKRecord {
    
    convenience init(user: User) {
        let recordID = user.cloudKitRecordID ?? CKRecordID(recordName: UUID().uuidString)
        
        self.init(recordType: User.recordTypeKey, recordID: recordID)
        
        self.setValue(user.firstName, forKey: User.firstNameKey)
        self.setValue(user.lastName, forKey: User.lastNameKey)
        self.setValue(user.email, forKey: User.emailKey)
        self.setValue(user.phone, forKey: User.phoneKey)
        if user.groupsRefs == [] {
        } else {
            self.setValue(user.groupsRefs, forKey: User.groupsRefsKey)
            
        }
        self.setValue(user.appleUserRef, forKey: User.appleUserRefKey)
    }
    
    
}



