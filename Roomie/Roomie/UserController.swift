//
//  UserController.swift
//  Roomie
//
//  Created by Alex Aslett on 9/20/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import Foundation
import CloudKit

class UserController {
    
    static let shared = UserController()
    let currentUserWasSetNotification = Notification.Name("currentUserWasSet")
    
    
    let cloudKitManager: CloudKitManager = {
        return CloudKitManager()
    }()
    
    var currentUser: User? {
        didSet {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: self.currentUserWasSetNotification, object: nil)
            }
        }
    }
    
    func createUserWith(firstName: String, lastName: String, email: String, phone: String?, completion: @escaping(_ success: Bool) -> Void) {
        CKContainer.default().fetchUserRecordID { (appleUsersRecordID, error) in
            guard let appleUsersRecordID = appleUsersRecordID else { completion(false); return }
            
            let appleUserRef = CKReference(recordID: appleUsersRecordID, action: .deleteSelf)
            let user = User(firstName: firstName, lastName: lastName, email: email, phone: phone, appleUserRef: appleUserRef)
            let userRecord = CKRecord(user: user)
            
            CKContainer.default().publicCloudDatabase.save(userRecord) { (record, error) in
                if let error = error {
                    print(error.localizedDescription)
                    completion(false)
                    return
                }
                guard let record = record else { completion(false); return }
                guard let currentUser = User(cloudKitRecord: record) else { completion(false); return }
                
                self.currentUser = currentUser
                completion(true)
                
            }
        }
    }
    
    func fetchCurrentUser(completion: @escaping (_ success: Bool) -> Void = { _ in }) {
        
        
        CKContainer.default().fetchUserRecordID { (appleUserRecordID, error) in
            if let error = error { print(error.localizedDescription) }
            guard let appleUserRecordID = appleUserRecordID else { completion(false); return }
            
            
            let appleUserReference = CKReference(recordID: appleUserRecordID, action: .deleteSelf)
            
            
            let predicate = NSPredicate(format: "appleUserRef == %@", appleUserReference)
        
            self.cloudKitManager.fetchRecordsWithType(User.recordTypeKey, predicate: predicate, recordFetchedBlock: nil) { (record, error) in
                if let error = error {
                    print(error)
                }
                guard let currentUserRecord = record?.first else { completion(false); return }
                let currentUser1 = User(cloudKitRecord: currentUserRecord)
                self.currentUser = currentUser1
                completion(true)
            }
            
        }
        
    }
    
    
}
