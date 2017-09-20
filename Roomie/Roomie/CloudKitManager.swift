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
    let privateDatabase = CKContainer.default().privateCloudDatabase
    
    
    func fetchRecord(withID recordID: CKRecordID, completion: ((_ record: CKRecord?, _ error: Error?) -> Void)?) {
        
        publicDatabase.fetch(withRecordID: recordID) { (record, error) in
            completion?(record, error)
        }
    }
    
    func fetchRecordsWithType(_ type: String,
                              predicate: NSPredicate = NSPredicate(value: true),
                              recordFetchedBlock: ((_ record: CKRecord) -> Void)?,
                              completion: ((_ records: [CKRecord]?, _ error: Error?) -> Void)?) {
        var fetchedRecords: [CKRecord] = []
        
        let query = CKQuery(recordType: type, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        let perRecordBlock = { (fetchedRecord: CKRecord) -> Void in
            fetchedRecords.append(fetchedRecord)
            recordFetchedBlock?(fetchedRecord)
            
        }
        
        
        queryOperation.recordFetchedBlock = perRecordBlock
        
        var queryCompletionBlock: (CKQueryCursor?, Error?) -> Void = { (_, _) in }
        queryCompletionBlock = { (queryCursor: CKQueryCursor?, error: Error?) -> Void in
            if let queryCursor = queryCursor {
                // there are more results
                
                let continuedQueryOperation = CKQueryOperation(cursor: queryCursor)
                continuedQueryOperation.recordFetchedBlock = perRecordBlock
                continuedQueryOperation.queryCompletionBlock = queryCompletionBlock
                
                self.publicDatabase.add(continuedQueryOperation)
            } else {
                completion?(fetchedRecords, error)
            }
            
        }
        
        queryOperation.queryCompletionBlock = queryCompletionBlock
        self.publicDatabase.add(queryOperation)
        
    }
    
    func fetchRecords(ofType type: String, withSortDescriptors sortDescriptors: [NSSortDescriptor]? = nil, completion: @escaping (([CKRecord]?, Error?) -> Void)) { // similar to dataTask
        
        let predicate = NSPredicate(value: true) // like a filter. a bit more specific. true = yes! i want everything
        
        let query = CKQuery(recordType: type, predicate: predicate)
        
        query.sortDescriptors = sortDescriptors // now we can pass in sort descriptors
        
        publicDataBase.perform(query, inZoneWith: nil, completionHandler: completion)
    }
    
    // MARK: - Delete
    
    func deleteRecordWithID(_ recordID: CKRecordID, completion: ((_ recordID: CKRecordID?, _ error: Error?) -> Void)?) {
        
        publicDatabase.delete(withRecordID: recordID) { (recordID, error) in
            completion?(recordID, error)
        }
    }
    
    func deleteRecordsWithID(_ recordIDs: [CKRecordID], completion: ((_ records: [CKRecord]?, _ recordIDs: [CKRecordID]?, _ error: Error?) -> Void)?) {
        
        let operation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: recordIDs)
        operation.savePolicy = .ifServerRecordUnchanged
        
        operation.modifyRecordsCompletionBlock = completion
        
        publicDatabase.add(operation)
    }
    
    func deleteOperation(_ record: CKRecord, completion: @escaping () -> Void) {
        let operation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: [record.recordID])
        operation.savePolicy = .changedKeys
        operation.queuePriority = .high
        operation.qualityOfService = .userInteractive // as fast as it gets
        
        publicDatabase.add(operation)
        completion()
    }
    
    // MARK: - Save and Modify
    
    func saveRecords(_ records: [CKRecord], perRecordCompletion: ((_ record: CKRecord?, _ error: Error?) -> Void)?, completion: ((_ records: [CKRecord]?, _ error: Error?) -> Void)?) {
        
        modifyRecords(records, perRecordCompletion: perRecordCompletion, completion: completion)
    }
    
    func saveRecord(_ record: CKRecord, completion: ((_ record: CKRecord?, _ error: Error?) -> Void)?) {
        
        publicDatabase.save(record, completionHandler: { (record, error) in
            
            completion?(record, error)
        })
    }
    
    func modifyRecords(_ records: [CKRecord], perRecordCompletion: ((_ record: CKRecord?, _ error: Error?) -> Void)?, completion: ((_ records: [CKRecord]?, _ error: Error?) -> Void)?) {
        
        let operation = CKModifyRecordsOperation(recordsToSave: records, recordIDsToDelete: nil)
        operation.savePolicy = .changedKeys
        operation.queuePriority = .high
        operation.qualityOfService = .userInteractive
        
        operation.perRecordCompletionBlock = perRecordCompletion
        
        operation.modifyRecordsCompletionBlock = { (records, recordIDs, error) -> Void in
            (completion?(records, error))!
        }
        
        publicDatabase.add(operation)
        
    }
    
    
    
}
