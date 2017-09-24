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
    
    var expenses = [Expense]()
    
    //FIXME: need to add lots of CRUD functions
    
    
    // Need functions to create a new expense and delete expenses
    
    func createNewExpense(title: String, amount: Double, paidDate: Date? = nil, payor: CKReference, payee:CKReference, groupID: CKReference, completion: () -> Void){
        
        let expense = Expense(title: title, amount: amount, paidDate: paidDate, payor: payor, payee: payee, groupID: groupID)
        expenses.append(expense)
        
//        cloudKitManager.saveRecord(CKRecord(expense)) { (record, error) in
//            <#code#>
//        }
        
    }
    
    func deleteExpense(expense: Expense){
        
    }
    
    
    
    
    
    
    
}
