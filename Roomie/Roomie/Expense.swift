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
    
    static let titleKey = "title"
    static let amountKey = "amount"
    static let creationDateKey = "creationDate"
    static let paidDateKey = "paidDate"
    static let payorKey = "payor"
    static let payeeKey = "payee"
    static let recordTypeKey = "Expense"
    
    var title: String
    var amount: Double
    var creationDate: Date
    var paidDate: Date?
    var payor: CKReference
    var payee: CKReference
    
    
    init(title: String, amount: Double, creationDate: Date, paidDate: Date?, payor: CKReference, payee: CKReference){
        self.title = title
        self.amount = amount
        self.creationDate = creationDate
        self.paidDate = paidDate
        self.payor = payor
        self.payee = payee
    }
    
//    init?(cloadKitRecord: CKRecord) {
//        guard cloadKitRecord.recordType == Expense.recordTypeKey, let
//    }
    
    
}
