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
    
    fileprivate static var taskNameKey: String { return "taskName" }
    fileprivate static var ownerKey: String { return "owner"}
    fileprivate static var isCompleteKey: String { return "isComplete" }
    static var dueDateKey: String { return "dueDate" }
    fileprivate static var groupKey: String { return "group" }
    static var recordType: String { return "Task" }
    
    var taskName: String
    var owner: CKReference
    var isComplete: Bool
    var dueDate: Date
    var group: CKReference
    
    var ckRecordID: CKRecordID?
    
    init(taskName: String, owner: CKReference, isComplete: Bool = false, dueDate: Date = Date(), group: CKReference) {
        
        self.taskName = taskName
        self.owner = owner
        self.isComplete = isComplete
        self.dueDate = dueDate
        self.group = group
    }
    
    init?(ckRecord: CKRecord) {
        guard let taskName = ckRecord[Task.taskNameKey] as? String,
            let owner = ckRecord[Task.ownerKey] as? CKReference,
            let isComplete = ckRecord[Task.isCompleteKey] as? Bool,
            let dueDate = ckRecord[Task.dueDateKey] as? Date,
            let group = ckRecord[Task.groupKey] as? CKReference else { return nil }

        self.taskName = taskName
        self.owner = owner
        self.isComplete = isComplete
        self.dueDate = dueDate
        self.group = group
        self.ckRecordID = ckRecord.recordID
    }
}

extension Task: Equatable {
    static func ==(lhs: Task, rhs: Task) -> Bool {
        return lhs.taskName == rhs.taskName && lhs.owner == rhs.owner && lhs.isComplete == rhs.isComplete && lhs.dueDate == rhs.dueDate && lhs.group == rhs.group && lhs.ckRecordID == rhs.ckRecordID
    }
}

extension CKRecord {
    convenience init(task: Task) {
        let recordID = task.ckRecordID ?? CKRecordID(recordName: UUID().uuidString)
        
        self.init(recordType: Task.recordType, recordID: recordID)
        self.setValue(task.taskName, forKey: Task.taskNameKey)
        self.setValue(task.owner, forKey: Task.ownerKey)
        self.setValue(task.isComplete, forKey: Task.isCompleteKey)
        self.setValue(task.dueDate, forKey: Task.dueDateKey)
        self.setValue(task.group, forKey: Task.groupKey)
    }
}
