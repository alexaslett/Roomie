//
//  UserController.swift
//  Roomie
//
//  Created by Alex Aslett on 9/20/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit
import CloudKit

class UserController {
    
    static let shared = UserController()
    let currentUserWasSetNotification = Notification.Name("currentUserWasSet")
    
    
    let cloudKitManager: CloudKitManager = {
        return CloudKitManager()
    }()
    
    var usersInCurrentGroup: [User] = []
    
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
                    print("Failed to fetch current user, \(error.localizedDescription)")
                }
                guard let currentUserRecord = record?.first else { completion(false); return }
                let currentUser1 = User(cloudKitRecord: currentUserRecord)
                self.currentUser = currentUser1
                completion(true)
            }
            
        }
        
    }
 
    func usersInGroup(group: Group, completion: @escaping (_ success: Bool) -> Void = { _ in }) {
        
        guard let groupCKID = group.cloudKitRecordID else { completion(true); return }
        
        
        let predicate = NSPredicate(format: "groupsRefs CONTAINS %@", groupCKID)
        
        cloudKitManager.fetchRecordsWithType(User.recordTypeKey, predicate: predicate, recordFetchedBlock: nil) { (records, error) in
            if let error = error {
                print("error fetching users in group \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let records = records else { completion(false); return }
            
            self.usersInCurrentGroup = records.flatMap { User(cloudKitRecord: $0) }
            completion(true)
        }
    }
    
    func editProfile(firstName: String, lastName: String, email: String, phone: String?, user: User, photo: UIImage? = nil, completion: @escaping(_ success: Bool) -> Void) {
        
        user.firstName = firstName
        user.lastName = lastName
        user.email = email
        user.phone = phone
        user.photo = photo
        
        let userRecord = CKRecord(user: user)
        
        cloudKitManager.modifyRecords([userRecord], perRecordCompletion: nil) { (records, error) in
            if let error = error {
                print("Error modifying records, \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let records = records?.first else { completion(false); return}
            self.currentUser = User(cloudKitRecord: records)
            
        }
    }
    
    
    
}













