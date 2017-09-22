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
    
    var task: Task?
    
    // MARK: - Create
    
    func createTask(taskName: String, owner: CKReference, ownerName: String, isComplete: Bool = false, dueDate: Date = Date(), group: CKReference, completion: @escaping ((Error?) -> Void) = { _ in }) {
        
        let task = Task(taskName: taskName, owner: owner, ownerName: ownerName, isComplete: isComplete, dueDate: dueDate, group: group)
        let taskRecord = CKRecord(task: task)
        
        cloudKitManager.saveRecord(taskRecord) { (record, error) in
            defer { completion(error) }
            
            if let error = error { NSLog("Error saving record \(#file) \(#function) \(error.localizedDescription)"); return }
            
            guard record != nil else { NSLog("cannot create task"); return }
            
            self.tasks.append(task)
        }
    }
    
    // MARK: - Retreive/Fetch
    
    func fetchTasks(completion: @escaping ((Error?) -> Void) = { _ in }) {
        let sortDescriptors = [NSSortDescriptor(key: Task.dueDateKey, ascending: false)]
        
        cloudKitManager.fetchRecords(ofType: Task.recordType, withSortDescriptors: sortDescriptors) { (records, error) in
            
            defer { completion(error) }
            
            if let error = error {
                NSLog("Error fetching task. \(#file) \(#function) \n\(error.localizedDescription)")
                return
            }
            guard let records = records else { return }
            
            self.tasks = records.flatMap { Task(ckRecord: $0) }
        }
    }
    
    // MARK: - Update
    
    func updateTask(task: Task?, owner: CKReference, ownerName: String, isComplete: Bool = false, dueDate: Date = Date(), group: CKReference, completion: @escaping ((_ success: Bool) -> Void) = { _ in }) {
        
        guard let task = task else { return }
        
        task.owner = owner
        task.ownerName = ownerName
        task.isComplete = isComplete
        task.dueDate = dueDate
        task.group = group
        
        let taskRecord = CKRecord(task: task)
        
        cloudKitManager.saveRecords([taskRecord], perRecordCompletion: { (_, error) in
            if let error = error {
                NSLog("Error updating task. \(#file) \(#function) \n\(error.localizedDescription)")
                return
            }
        }) { (records, error) in
            let success = records != nil
            completion(success)
        }
    }
    
    // MARK: - Delete
    
    func delete(recordID: CKRecordID, completion: @escaping ((Error?) -> Void) = { _ in }) {
        cloudKitManager.deleteRecordWithID(recordID) { (ckRecordID, error) in
            defer { completion(error) }
            
            if let error = error {
                NSLog("Error deleting task. \(#file) \(#function) \n\(error.localizedDescription)")
                return
            }
        }
    } // ** check to see if the app works without the above function
    
    func deleteTask(task: Task) {
        let record = CKRecord(task: task)
        cloudKitManager.deleteOperation(record) { 
            guard let index = self.tasks.index(of: task) else { return }
            self.tasks.remove(at: index)
        }
    }
}
