//
//  WerePaidTableViewCell.swift
//  Roomie
//
//  Created by Alex Aslett on 9/27/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class WerePaidTableViewCell: UITableViewCell {

    var expense: Expense?
    
    
    @IBOutlet weak var personWhoPaidLabel: UILabel!
    @IBOutlet weak var expenseTitleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    
    func updateWerePaidCell() {
        guard let expense = expense else { return }
        personWhoPaidLabel.text = expense.payeeName
        expenseTitleLabel.text = expense.title
        amountLabel.text = "\(expense.amount)"
        
    }
    
}
