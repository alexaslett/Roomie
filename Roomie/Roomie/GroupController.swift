//
//  GroupController.swift
//  Roomie
//
//  Created by macbook pro on 9/20/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit
import GameKit
import CloudKit

class GroupController {
    
    static let shared = GroupController()
    
    let cloudKitManager: CloudKitManager = {
        return CloudKitManager()
    }()
    
    var groups: [Group] = []
    var currentGroup: Group?
    
    var newGroup: Group? {
        didSet{
            
        }
    }
    
    // MARK - Password generator
    
    let pwCharacters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","1","2","3","4","5","6","7","8","9","0","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y"]
    
    func randomPassword(passwordLength: Int) -> String{
        var password = ""
        let arrayCount = UInt32(pwCharacters.count)
        for _ in 0 ..< passwordLength {
            let randomNumber = Int(arc4random_uniform(arrayCount))
            password += pwCharacters[randomNumber]
        }
        return password
    }
    
    
    
    
    func createNewGroup(groupName: String, passcode: String, completion: @escaping(_ success: Bool) -> Void) {
        let group = Group(groupName: groupName, passcode: passcode)
        
        let groupRecord = CKRecord(group: group)
        CKContainer.default().publicCloudDatabase.save(groupRecord) { (record, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
                return
            }
            guard let record = record else { completion(false); return }
            
            group.cloudKitRecordID = record.recordID
            
            self.groups.append(group)
            
            // call func to add group
            self.addGroupRefToUser(record: record, completion: completion)
        }
    }
    
    
    func addGroupRefToUser(record: CKRecord, completion: @escaping (_ success: Bool) -> Void) {
        guard let currentUser = UserController.shared.currentUser else { completion(false); return }
        let groupRef = CKReference(record: record, action: .none)
        currentUser.groupsRefs.append(groupRef)
        let userRecord = CKRecord(user: currentUser)
        cloudKitManager.modifyRecords([userRecord], perRecordCompletion: nil) { (_, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
                return
            }
            completion(true)
        }
        
        
    }
    
    func fetchGroup(completion: @escaping (_ success: Bool) -> Void = { _ in }){
        guard let currentUser = UserController.shared.currentUser else { completion(false); return }
        
        let groupCKRef = currentUser.groupsRefs
        
        var groupsCKID: [CKRecordID] = []
        
        for groupRef in groupCKRef {
            let groupCKID = groupRef.recordID
            groupsCKID.append(groupCKID)
        }
        
        cloudKitManager.fetchRecords(withIDs: groupsCKID) { (groupCKDict, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
                return
            }
            guard let groupCKDict = groupCKDict else { completion(true); return }
            var groups1: [Group] = []
            for groupCKRecord in groupCKDict.values {
                guard let group = Group(cloudkitRecord: groupCKRecord) else { completion(false); return }
                groups1.append(group)
            }
                self.groups = groups1
            completion(true)
            
        }
        
        
        
    }
    
    
    
}











