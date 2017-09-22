//
//  Group.swift
//  Roomie
//
//  Created by macbook pro on 9/20/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit
import CloudKit

class Group {
    
    static let groupNameKey = "groupName"
    static let passcodeKey = "passcode"
    static let recordTypeKey = "group"
    
    let groupName: String
    let passcode: String
    
    var cloudKitRecordID: CKRecordID?
    
    init(groupName: String, passcode: String){
        self.groupName = groupName
        self.passcode = passcode
    }
    
    init?(cloudkitRecord: CKRecord) {
        
        guard let groupName = cloudkitRecord[Group.groupNameKey] as? String,
            let passcode = cloudkitRecord[Group.passcodeKey] as? String
            else { return nil }
        
        self.groupName = groupName
        self.passcode = passcode
        self.cloudKitRecordID = cloudkitRecord.recordID
        
    }
    
//    var cloudKitRecord: CKRecord {
//        let record = CKRecord(recordType: Group.recordTypeKey)
//        record.setValue(groupName, forKey: Group.groupNameKey)
//        record.setValue(passcode, forKey: Group.passcodeKey)
//        return record
//    }
    
}

extension CKRecord {
    
    convenience init(group: Group) {
        
        let recordID = group.cloudKitRecordID ?? CKRecordID(recordName: UUID().uuidString)
        
        self.init(recordType: Group.recordTypeKey, recordID: recordID)
        self.setValue(group.groupName, forKey: Group.groupNameKey)
        self.setValue(group.passcode, forKey: Group.passcodeKey)
        
    }
}






