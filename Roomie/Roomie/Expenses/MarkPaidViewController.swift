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

        // Do any additional setup after loading the view.
        updateViews()
    }
    @IBOutlet weak var oweLabel: UILabel!
    @IBOutlet weak var amountOwedLabel: UILabel!
    @IBOutlet weak var expenseNameLabel: UILabel!
    
    var expense: Expense?
    
    func updateViews(){
        guard let expense = expense else { return }
        amountOwedLabel.text = "\(expense.amount)"
        expenseNameLabel.text = expense.title
        oweLabel.text = expense.payeeName
    }
    
    @IBAction func markPaidButtonClicked(_ sender: Any) {
        
    }
    
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        
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
