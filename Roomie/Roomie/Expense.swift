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
    static let payorKey = "payor"
    static let payeeKey = "payee"
    static let groupIDKey = "groupID"
    static let isPaidKey = "isPaid"
    static let isDeletedKey = "isDeleted"
    static let payorNameKey = "payorName"
    static let payeeNameKey = "payeeName"
    static let recordTypeKey = "Expense"
    
    var cloudKitRecordID: CKRecordID?
    
    var title: String
    var amount: Double
    var payor: CKReference
    var payee: CKReference
    var groupID: CKReference
    var isPaid: Bool
    var isDeleted: Bool
    var payorName: String
    var payeeName: String
    
    
    init(title: String, amount: Double, payor: CKReference, payee: CKReference, groupID: CKReference, isPaid: Bool = false, isDeleted: Bool = false, payorName: String, payeeName: String){
        self.title = title
        self.amount = amount
        self.payor = payor
        self.payee = payee
        self.groupID = groupID
        self.isPaid = isPaid
        self.isDeleted = isDeleted
        self.payorName = payorName
        self.payeeName = payeeName
    }
    
    init?(cloudKitRecord: CKRecord) {
        guard cloudKitRecord.recordType == Expense.recordTypeKey,
            let title = cloudKitRecord[Expense.titleKey] as? String,
            let amount = cloudKitRecord[Expense.amountKey] as? Double,
            let payor = cloudKitRecord[Expense.payorKey] as? CKReference,
            let payee = cloudKitRecord[Expense.payeeKey] as? CKReference,
            let groupID = cloudKitRecord[Expense.groupIDKey] as? CKReference,
            let isPaid = cloudKitRecord[Expense.isPaidKey] as? Bool,
            let isDeleted = cloudKitRecord[Expense.isDeletedKey] as? Bool,
            let payorName = cloudKitRecord[Expense.payorNameKey] as? String,
            let payeeName = cloudKitRecord[Expense.payeeNameKey] as? String else { return nil }
        
        self.title = title
        self.amount = amount
        self.payor = payor
        self.payee = payee
        self.groupID = groupID
        self.isPaid = isPaid
        self.isDeleted = isDeleted
        self.payorName = payorName
        self.payeeName = payeeName
        
    }
}

extension CKRecord {
    
    convenience init(_ expense: Expense){
        let recordID = expense.cloudKitRecordID ?? CKRecordID(recordName: UUID().uuidString)
        
        self.init(recordType: Expense.recordTypeKey, recordID: recordID)
        
        self.setValue(expense.title, forKey: Expense.titleKey)
        self.setValue(expense.amount, forKey: Expense.amountKey)
        self.setValue(expense.payor, forKey: Expense.payorKey)
        self.setValue(expense.payee, forKey: Expense.payeeKey)
        self.setValue(expense.groupID, forKey: Expense.groupIDKey)
        self.setValue(expense.isPaid, forKey: Expense.isPaidKey)
        self.setValue(expense.isDeleted, forKey: Expense.isDeletedKey)
        self.setValue(expense.payorName, forKey: Expense.payorNameKey)
        self.setValue(expense.payeeName, forKey: Expense.payeeNameKey)
        
    }
}
