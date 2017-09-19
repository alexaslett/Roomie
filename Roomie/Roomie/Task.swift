//
//  Task.swift
//  Roomie
//
//  Created by Kaitlyn Barker on 9/19/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import Foundation
import CloudKit

class Task {
    
    private static var ownerKey: String { return "owner"}
    private static var isCompleteKey: String { return "isComplete" }
    private static var dueDateKey: String { return "dueDate" }
    static var recordType: String { return "Task" }
    
    let owner: CKReference
    let isComplete: Bool
    let dueDate: Date
    
    var ckRecordID: CKRecordID?
    
    init(owner: CKReference, isComplete: Bool, dueDate: Date = Date()) {
        self.owner = owner
        self.isComplete = isComplete
        self.dueDate = dueDate
    }
    
    init?(ckRecord: CKRecord) {
        guard let owner = ckRecord[Task.ownerKey] as? CKReference,
        let isComplete = ckRecord[Task.isCompleteKey] as? Bool,
            let dueDate = ckRecord[Task.dueDateKey] as? Date else { return nil }
        
        self.owner = owner
        self.isComplete = isComplete
        self.dueDate = dueDate
        self.ckRecordID = ckRecord.recordID
    }
    
    var ckRecord: CKRecord {
        let record = CKRecord(recordType: Task.recordType)
        record.setValue(self.owner, forKey: Task.ownerKey)
        record.setValue(self.isComplete, forKey: Task.isCompleteKey)
        record.setValue(self.dueDate, forKey: Task.dueDateKey)
        
        return record
    }
}

extension Task: Equatable {
    static func ==(lhs: Task, rhs: Task) -> Bool {
        return lhs.owner == rhs.owner && lhs.isComplete == rhs.isComplete && lhs.dueDate == rhs.dueDate && lhs.ckRecordID == rhs.ckRecordID
    }
}
