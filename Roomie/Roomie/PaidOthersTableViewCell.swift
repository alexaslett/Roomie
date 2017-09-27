//
//  PaidOthersTableViewCell.swift
//  Roomie
//
//  Created by Alex Aslett on 9/27/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class PaidOthersTableViewCell: UITableViewCell {

    var expense: Expense?
    
    
    @IBOutlet weak var personPaidLabel: UILabel!
    @IBOutlet weak var expenseTitleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    
    func updateYouPaidCell() {
        guard let expense = expense else { return }
        personPaidLabel.text = expense.payorName
        expenseTitleLabel.text = expense.title
        amountLabel.text = "\(expense.amount)"
    }
}
