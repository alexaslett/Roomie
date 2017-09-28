//
//  oweExpenseTableViewCell.swift
//  Roomie
//
//  Created by Alex Aslett on 9/26/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class oweExpenseTableViewCell: UITableViewCell {

    var oweExpense: Expense?
    
    @IBOutlet weak var payorNameLabel: UILabel!
    @IBOutlet weak var expenseTitleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    func updateTable() {
        guard let oweExpense = oweExpense else { return }
        payorNameLabel.text = oweExpense.payorName
        expenseTitleLabel.text = oweExpense.title
        amountLabel.text = "$\(String(format: "%.2f", oweExpense.amount))"
    }

}
