//
//  MarkPaidViewController.swift
//  Roomie
//
//  Created by Alex Aslett on 9/22/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class MarkPaidViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.ivoryWhite60
        
        updateViews()
        
        markPaidButton.layer.shadowColor = UIColor.black.cgColor
        markPaidButton.layer.shadowRadius = 2
        markPaidButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        markPaidButton.layer.shadowOpacity = 0.5
        
        deleteButton.layer.shadowColor = UIColor.black.cgColor
        deleteButton.layer.shadowRadius = 2
        deleteButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        deleteButton.layer.shadowOpacity = 0.5
    }
    @IBOutlet weak var oweLabel: UILabel!
    @IBOutlet weak var personLabel: UILabel!
    @IBOutlet weak var amountOwedLabel: UILabel!
    @IBOutlet weak var expenseNameLabel: UILabel!
    @IBOutlet weak var owesYouLabel: UILabel!
    @IBOutlet weak var markPaidButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    var expense: Expense?
    var isOwed: Bool = false
    
    func updateViews(){
        guard let expense = expense else { return }
        
        amountOwedLabel.text = "$\(String(format: "%.2f", expense.amount))"
        expenseNameLabel.text = expense.title
        if isOwed {
            personLabel.text = expense.payeeName
            oweLabel.isHidden = true
        } else {
            personLabel.text = expense.payorName
            owesYouLabel.isHidden = true
        }
    }
    
    @IBAction func markPaidButtonClicked(_ sender: Any) {
        guard let expense = expense else { return }
        
        ExpenseController.shared.editExpense(expense: expense) { (success) in
            if success {
                let expenseSummeryVC = self.navigationController?.viewControllers[0] as! ExpenseSummaryViewController
                self.navigationController?.popToViewController(expenseSummeryVC, animated: true)
            }
        }
    }
    
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        guard let expense = expense else { return }
        ExpenseController.shared.deleteExpense(expense: expense) { (success) in
            let expenseSummeryVC = self.navigationController?.viewControllers[0] as! ExpenseSummaryViewController
            self.navigationController?.popToViewController(expenseSummeryVC, animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
