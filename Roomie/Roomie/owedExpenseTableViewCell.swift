//
//  owedExpenseTableViewCell.swift
//  Roomie
//
//  Created by Alex Aslett on 9/26/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class owedExpenseTableViewCell: UITableViewCell {

    var owedExpense: Expense?
    
    @IBOutlet weak var personWhoOwesYouLabel: UILabel!
    @IBOutlet weak var expenseTitleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    func updateTable(){
        guard let owedExpense = owedExpense else { return }
        personWhoOwesYouLabel.text = owedExpense.payeeName
        expenseTitleLabel.text = owedExpense.title
        amountLabel.text = "\(owedExpense.amount)"
    }
    
}
