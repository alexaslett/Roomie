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
    
    func fetchOweExpensesByGroup(completion: @escaping (_ success: Bool) -> Void = { _ in }){
        
        guard let groupRecID = GroupController.shared.currentGroup?.cloudKitRecordID,
            let userRecID = UserController.shared.currentUser?.cloudKitRecordID else { completion(false); return}
        
        let groupRef = CKReference(recordID: groupRecID, action: .none)
        let userRef = CKReference(recordID: userRecID, action: .none)
        
        let predicate1 = NSPredicate(format: "groupID == %@", groupRef)
        let predicate2 = NSPredicate(format: "payee == %@", userRef)
        let predicate3 = NSPredicate(format: "isPaid == false")
        
        let compoundPredicate = NSCompoundPredicate.init(andPredicateWithSubpredicates: [predicate1, predicate2, predicate3])
        
        cloudKitManager.fetchRecordsWithType(Expense.recordTypeKey, predicate: compoundPredicate, recordFetchedBlock: nil) { (records, error) in
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
    
    func fetchOweExpensesByGroupPaid(completion: @escaping (_ success: Bool) -> Void = { _ in }){
        
        guard let groupRecID = GroupController.shared.currentGroup?.cloudKitRecordID,
            let userRecID = UserController.shared.currentUser?.cloudKitRecordID else { completion(false); return}
        
        let groupRef = CKReference(recordID: groupRecID, action: .none)
        let userRef = CKReference(recordID: userRecID, action: .none)
        
        let predicate1 = NSPredicate(format: "groupID == %@", groupRef)
        let predicate2 = NSPredicate(format: "payee == %@", userRef)
        let predicate3 = NSPredicate(format: "isPaid == true")
        
        let compoundPredicate = NSCompoundPredicate.init(andPredicateWithSubpredicates: [predicate1, predicate2, predicate3])
        
        cloudKitManager.fetchRecordsWithType(Expense.recordTypeKey, predicate: compoundPredicate, recordFetchedBlock: nil) { (records, error) in
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
    
    
    
    
}
