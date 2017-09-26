//
//  ExpenseHistoryTableViewCell.swift
//  Roomie
//
//  Created by Alex Aslett on 9/26/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class ExpenseHistoryTableViewCell: UITableViewCell {

    var histExpense: Expense?
    
    @IBOutlet weak var personPaidLabel: UILabel!
    @IBOutlet weak var expenseTitleLabel: UILabel!
    @IBOutlet weak var expensePriceLabel: UILabel!
    
    func updateTable(){
        guard let histExpense = histExpense else { return }
        
        personPaidLabel.text = histExpense.payorName
        expenseTitleLabel.text = histExpense.title
        expensePriceLabel.text = "\(histExpense.amount)"
        
    }

}
