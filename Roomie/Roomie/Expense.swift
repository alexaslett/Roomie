//
//  Expense.swift
//  Roomie
//
//  Created by Alex Aslett on 9/19/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import Foundation
import CloudKit

class Expense {
    
    //Think we get the creation date for free so removing those for now
    
    static let titleKey = "title"
    static let amountKey = "amount"
    static let paidDateKey = "paidDate"
    static let payorKey = "payor"
    static let payeeKey = "payee"
    static let groupIDKey = "groupID"
    static let recordTypeKey = "Expense"
    
    var cloudKitRecordID: CKRecordID?
    
    var title: String
    var amount: Double
    var paidDate: Date?
    var payor: CKReference
    var payee: CKReference
    var groupID: CKReference
    
    
    init(title: String, amount: Double, paidDate: Date?, payor: CKReference, payee: CKReference, groupID: CKReference){
        self.title = title
        self.amount = amount
        self.paidDate = paidDate
        self.payor = payor
        self.payee = payee
        self.groupID = groupID
    }
    
    init?(cloudKitRecord: CKRecord) {
        guard cloudKitRecord.recordType == Expense.recordTypeKey,
            let title = cloudKitRecord[Expense.titleKey] as? String,
            let amount = cloudKitRecord[Expense.amountKey] as? Double,
            let paidDate = cloudKitRecord[Expense.paidDateKey] as? Date,
            let payor = cloudKitRecord[Expense.payorKey] as? CKReference,
            let payee = cloudKitRecord[Expense.payeeKey] as? CKReference,
            let groupID = cloudKitRecord[Expense.groupIDKey] as? CKReference else { return nil }
        
        self.title = title
        self.amount = amount
        self.paidDate = paidDate
        self.payor = payor
        self.payee = payee
        self.groupID = groupID
        
    }
}

extension CKRecord {
    
    convenience init(_ expense: Expense){
        let recordID = expense.cloudKitRecordID ?? CKRecordID(recordName: UUID().uuidString)
        
        self.init(recordType: Expense.recordTypeKey, recordID: recordID)
        
        self.setValue(expense.title, forKey: Expense.titleKey)
        self.setValue(expense.amount, forKey: Expense.amountKey)
        self.setValue(expense.paidDate, forKey: Expense.paidDateKey)
        self.setValue(expense.payor, forKey: Expense.payorKey)
        self.setValue(expense.payee, forKey: Expense.payeeKey)
        self.setValue(expense.groupID, forKey: Expense.groupIDKey)
        
    }
}
