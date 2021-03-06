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
    
    func createTask(taskName: String, owner: CKReference, ownerName: String, dueDate: Date = Date(), group: CKReference, completion: @escaping ((Bool) -> Void) = { _ in }) {
        
        let task = Task(taskName: taskName, owner: owner, ownerName: ownerName, dueDate: dueDate, group: group)
        let choreRecord = CKRecord(task: task)
        
        cloudKitManager.saveRecord(choreRecord) { (record, error) in
            
            if let error = error {NSLog("Error saving record \(#file) \(#function) \(error.localizedDescription)"); completion(false); return }
            
            task.ckRecordID = record?.recordID
            
            self.tasks.append(task)
            completion(true)
        }
    }
    
    // MARK: - Retreive/Fetch
    
    func fetchTasks(completion: @escaping (_ success: Bool) -> Void = { _ in }) {
        
        let sortDescriptors = [NSSortDescriptor(key: Task.dueDateKey, ascending: false)]
        
        guard let groupCKRecordID = GroupController.shared.currentGroup?.cloudKitRecordID else { completion(false); return }
        
        let groupRef = CKReference(recordID: groupCKRecordID, action: .none)
        let predicate = NSPredicate(format: "group == %@", groupRef)
        
        cloudKitManager.fetchRecordsWithType(Task.recordType, predicate: predicate, sortDescriptors: sortDescriptors, recordFetchedBlock: nil) { (records, error) in
            
            
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
    
    // MARK: - Update
    
    func updateTasks(task: Task?, taskName: String, owner: CKReference, ownerName: String, dueDate: Date = Date(), group: CKReference, completion: @escaping ((_ success: Bool) -> Void) = { _ in }) {
        
        guard let task = task else { completion(false); return }
        
        task.taskName = taskName
        task.owner = owner
        task.ownerName = ownerName
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
