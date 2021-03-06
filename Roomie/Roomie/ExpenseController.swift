//
//  ExpenseController.swift
//  Roomie
//
//  Created by Alex Aslett on 9/20/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import Foundation
import CloudKit

class ExpenseController {
    
    static let shared = ExpenseController()
    
    let cloudKitManager: CloudKitManager
    
    init() {
        self.cloudKitManager = CloudKitManager()
    }
    
    var oweExpenses: [Expense] = []
    var owedExpenses: [Expense] = []
    var paidExpenses: [Expense] = []
    var othersPaidExpenses: [Expense] = []
    
    
    //FIXME: need to add lots of CRUD functions
    
    
    // Need functions to create a new expense and delete expenses
  
    func createExpense(title: String, amount: Double, payor: CKReference, payee: CKReference, groupID: CKReference, payorName: String, payeeName: String, completion: @escaping (_ success: Bool) -> Void = { _ in })  {
        let expense = Expense(title: title, amount: amount, payor: payor, payee: payee, groupID: groupID, payorName: payorName, payeeName: payeeName)
        let expenseRecord = CKRecord(expense)
        
        cloudKitManager.saveRecord(expenseRecord) { (record, error) in
            if let error = error {
                print("Error saving record to cloudKit \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let record = record else { completion(false); return }
            
            expense.cloudKitRecordID = record.recordID
        }
     
        completion(true)
    }
    
    func saveMultipleExpenses(_ expenseRecords: [CKRecord], completion: @escaping (_ success: Bool) -> Void = { _ in }) {
        
        cloudKitManager.saveRecords(expenseRecords, perRecordCompletion: nil) { (_, error) in
            if let error = error {
                print("Error saving expense to cloudkit \(error.localizedDescription)")
                completion(false)
                return
            }
        }
        completion(true)
    }
    
    
    func fetchOweExpensesByGroup(completion: @escaping (_ success: Bool) -> Void = { _ in }){
        
        guard let groupRecID = GroupController.shared.currentGroup?.cloudKitRecordID,
            let userRecID = UserController.shared.currentUser?.cloudKitRecordID else { completion(false); return}
        
        let groupRef = CKReference(recordID: groupRecID, action: .none)
        let userRef = CKReference(recordID: userRecID, action: .none)
        
        let predicate1 = NSPredicate(format: "groupID == %@", groupRef)
        let predicate2 = NSPredicate(format: "payee == %@", userRef)
        let predicate3 = NSPredicate(format: "isPaid == false")
        
        let compoundPredicate = NSCompoundPredicate.init(andPredicateWithSubpredicates: [predicate1, predicate2, predicate3])
        
        let sortDescriptor = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        
        
        cloudKitManager.fetchRecordsWithType(Expense.recordTypeKey, predicate: compoundPredicate, sortDescriptors: sortDescriptor, recordFetchedBlock: nil) { (records, error) in
            if let error = error {
                print("Error fetching Owe expenses \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let oweExpenses1 = records else { completion(false); return }
            
            self.oweExpenses = oweExpenses1.flatMap { Expense(cloudKitRecord: $0) }
            completion(true)
        }
    }
    
    func fetchOwedExpensesByGroup(completion: @escaping (_ success: Bool) -> Void = { _ in }){
        
        guard let groupRecID = GroupController.shared.currentGroup?.cloudKitRecordID,
            let userRecID = UserController.shared.currentUser?.cloudKitRecordID else { completion(false); return}
        
        let groupRef = CKReference(recordID: groupRecID, action: .none)
        let userRef = CKReference(recordID: userRecID, action: .none)
        
        let predicate1 = NSPredicate(format: "groupID == %@", groupRef)
        let predicate2 = NSPredicate(format: "payor == %@", userRef)
        let predicate3 = NSPredicate(format: "isPaid == false")
        
        let compoundPredicate = NSCompoundPredicate.init(andPredicateWithSubpredicates: [predicate1, predicate2, predicate3])
        let sortDescriptor = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        cloudKitManager.fetchRecordsWithType(Expense.recordTypeKey, predicate: compoundPredicate, sortDescriptors: sortDescriptor, recordFetchedBlock: nil) { (records, error) in
            if let error = error {
                print("Error fetching Owed expenses \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let owedExpenses1 = records else { completion(false); return }
            
            self.owedExpenses = owedExpenses1.flatMap { Expense(cloudKitRecord: $0) }
            completion(true)
        }
    }
    
    
    func fetchPaidExpensesByGroup(completion: @escaping (_ success: Bool) -> Void = { _ in }){
        
        guard let groupRecID = GroupController.shared.currentGroup?.cloudKitRecordID,
            let userRecID = UserController.shared.currentUser?.cloudKitRecordID else { completion(false); return}
        
        let groupRef = CKReference(recordID: groupRecID, action: .none)
        let userRef = CKReference(recordID: userRecID, action: .none)
        
        let predicate1 = NSPredicate(format: "groupID == %@", groupRef)
        //FIXME: Really need to an OR operator here for both payor and payee
        let predicate2 = NSPredicate(format: "payee == %@", userRef)
        let predicate3 = NSPredicate(format: "isPaid == true")
        
        let compoundPredicate = NSCompoundPredicate.init(andPredicateWithSubpredicates: [predicate1, predicate2, predicate3])
        
        let sortDescriptor = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        cloudKitManager.fetchRecordsWithType(Expense.recordTypeKey, predicate: compoundPredicate, sortDescriptors: sortDescriptor, recordFetchedBlock: nil) { (records, error) in
            if let error = error {
                print("Error fetching paid expenses \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let paidExpenses1 = records else { completion(false); return }
            
            self.paidExpenses = paidExpenses1.flatMap { Expense(cloudKitRecord: $0) }
            completion(true)
        }
    }
    
    func fetchOthersPaidExpensesByGroup(completion: @escaping (_ success: Bool) -> Void = { _ in }){
        
        guard let groupRecID = GroupController.shared.currentGroup?.cloudKitRecordID,
            let userRecID = UserController.shared.currentUser?.cloudKitRecordID else { completion(false); return}
        
        let groupRef = CKReference(recordID: groupRecID, action: .none)
        let userRef = CKReference(recordID: userRecID, action: .none)
        
        let predicate1 = NSPredicate(format: "groupID == %@", groupRef)
        //FIXME: Really need to an OR operator here for both payor and payee
        let predicate2 = NSPredicate(format: "payor == %@", userRef)
        let predicate3 = NSPredicate(format: "isPaid == true")
        
        let compoundPredicate = NSCompoundPredicate.init(andPredicateWithSubpredicates: [predicate1, predicate2, predicate3])
        
        let sortDescriptor = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        cloudKitManager.fetchRecordsWithType(Expense.recordTypeKey, predicate: compoundPredicate, sortDescriptors: sortDescriptor, recordFetchedBlock: nil) { (records, error) in
            if let error = error {
                print("Error fetching paid expenses \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let othersPaidExpenses = records else { completion(false); return }
            
            self.othersPaidExpenses = othersPaidExpenses.flatMap { Expense(cloudKitRecord: $0) }
            completion(true)
        }
    }
    
    func editExpense(expense: Expense, completion: @escaping (_ success: Bool) -> Void = { _ in }) {
        
        expense.isPaid = true
        
        let expenseRecord = CKRecord(expense)
        
        cloudKitManager.modifyRecords([expenseRecord], perRecordCompletion: nil) { (records, error) in
            if let error = error {
                print("Error modifying records, \(error.localizedDescription)")
                completion(false)
                return
            }
        }
        completion(true)
    }
    
    func deleteExpense(expense: Expense, completion: @escaping (_ success: Bool) -> Void = { _ in }) {
        let expenseRecord = CKRecord(expense)
        
        cloudKitManager.deleteOperation(expenseRecord) {
        
        }
        completion(true)
    }
}
