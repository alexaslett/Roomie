//
//  CloudKitManager.swift
//  Roomie
//
//  Created by Alex Aslett on 9/19/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitManager {
    
    let publicDatabase = CKContainer.default().publicCloudDatabase
    
    func fetchRecord(ofType type: String, sortDescriptors: [NSSortDescriptor]? = nil, completion: @escaping ([CKRecord]?, Error?) -> Void) {
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: type, predicate: predicate)
        query.sortDescriptors = sortDescriptors
        
        publicDatabase.perform(query, inZoneWith: nil, completionHandler: completion)
    }
    
    func save(_ record: CKRecord, completion: @escaping (CKRecord?, Error?) -> Void = { _ in }) {
        publicDatabase.save(record, completionHandler: completion)
    }
    
    func update(_ record: CKRecord, completion: @escaping () -> Void) {
        let operation = CKModifyRecordsOperation(recordsToSave: [record], recordIDsToDelete: nil)
        operation.savePolicy = .changedKeys
        operation.queuePriority = .high
        operation.qualityOfService = .userInteractive
        publicDatabase.add(operation)
        completion()
    }
    
    func delete(_ record: CKRecord, completion: @escaping () -> Void) {
        let operation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: [record.recordID])
        operation.savePolicy = .changedKeys
        operation.queuePriority = .high
        operation.qualityOfService = .userInteractive
        publicDatabase.add(operation)
        completion()
    }
    
    
    
    //    func subscription(type: String, completion: @escaping((Error?) -> Void) = { _ in }) {
    //        let subscription = CKQuerySubscription(recordType: type, predicate: NSPredicate(value: true), options: .firesOnRecordCreation)
    //
    //
    //        let notificationInfo = CKNotificationInfo()
    //        notificationInfo.alertBody = "There is a new message on the board"
    //        notificationInfo.soundName = "default"
    //        notificationInfo.shouldBadge = true
    //
    //        subscription.notificationInfo = notificationInfo
    //
    //        publicDatabase.save(subscription) { (_, error) in
    //            if let error = error {
    //                print(error.localizedDescription)
    //            }
    //            completion(error)
    //        }
    //        
    //    }
    //    
    
    
}
