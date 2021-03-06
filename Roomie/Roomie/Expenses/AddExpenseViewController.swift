//
//  AddExpenseViewController.swift
//  Roomie
//
//  Created by Alex Aslett on 9/22/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class AddExpenseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.ivoryWhite60
        amountTextField.keyboardType = .decimalPad
        
        hideKeyboardWhenViewIsTapped()

        chooseSplitButton.tintColor = UIColor.tealBlue30
    }

    @IBOutlet weak var expenseNameTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var chooseSplitButton: UIButton!
    
    
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChooseSplit" {
            guard let destinationVC = segue.destination as? SplitExpensesViewController else { return }
            guard let expenseAmount = Double(amountTextField.text!) else { return }
            destinationVC.splitAmount = expenseAmount
            destinationVC.itemName = expenseNameTextField.text 
            
        }
    }
    

}
