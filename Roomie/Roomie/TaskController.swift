//
//  TaskController.swift
//  Roomie
//
//  Created by Kaitlyn Barker on 9/20/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import Foundation
import CloudKit

class TaskController {
    
    static let shared = TaskController()
    
    let cloudKitManager: CloudKitManager = {
        return CloudKitManager()
    }()
    
    var tasks: [Task] = []
    
    // MARK: - Create
    
    func createTask(owner: CKReference, isComplete: Bool = false, dueDate: Date = Date(), group: CKReference, completion: @escaping ((Error?) -> Void) = { _ in }) {
        
        let task = Task(owner: owner, isComplete: isComplete, dueDate: dueDate, group: group)
        let taskRecord = CKRecord(task: task)
        
        cloudKitManager.saveRecord(taskRecord) { (record, error) in
            defer { completion(error) }
            
            if let error = error { NSLog("Error saving record \(#file) \(#function) \(error.localizedDescription)"); return }
            
            guard record != nil else { NSLog("cannot create task"); return }
            
            self.tasks.append(task)
        }
    }
}
