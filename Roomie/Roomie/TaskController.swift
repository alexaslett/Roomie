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
    
    func createTask(taskName: String, owner: CKReference, ownerName: String, dueDate: Date = Date(), group: CKReference, completion: @escaping ((Error?) -> Void) = { _ in }) {
        
        let task = Task(taskName: taskName, owner: owner, ownerName: ownerName, dueDate: dueDate, group: group)
        let choreRecord = CKRecord(task: task)
        
        cloudKitManager.saveRecord(choreRecord) { (record, error) in
            defer { completion(error) }
            
            if let error = error { NSLog("Error saving record \(#file) \(#function) \(error.localizedDescription)"); return }
            
            guard record != nil else { NSLog("cannot create task"); return }
            
            self.tasks.append(task)
        }
    }
    
    // MARK: - Retreive/Fetch
    
    func fetchTasks(completion: @escaping (_ success: Bool) -> Void = { _ in }) {
        guard let groupCKRecordID = GroupController.shared.currentGroup?.cloudKitRecordID else { completion(false); return }
        
        let groupRef = CKReference(recordID: groupCKRecordID, action: .none)
        let predicate = NSPredicate(format: "group == %@", groupRef)
        
        cloudKitManager.fetchRecordsWithType(Task.recordType, predicate: predicate, recordFetchedBlock: nil) { (records, error) in
            
            if let error = error {
                NSLog("Error fetching tasks. \(#file) \(#function) \n\(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let groupTasks = records else { completion(false); return }
            let tasks = groupTasks.flatMap { Task(ckRecord: $0) }
            
            self.tasks = tasks
            
            completion(true)
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
