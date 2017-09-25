//
//  ExpenseSummaryViewController.swift
//  Roomie
//
//  Created by macbook pro on 9/22/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class ExpenseSummaryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        ExpenseController.shared.fetchOweExpensesByGroup { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ExpenseController.shared.fetchOweExpensesByGroup { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var youOweLabel: UILabel!
    @IBOutlet weak var youAreOwedLabel: UILabel!
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ExpenseController.shared.oweExpenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath)
        let oweExpense = ExpenseController.shared.oweExpenses[indexPath.row]
        
        cell.textLabel?.text = oweExpense.title
        cell.detailTextLabel?.text = "\(oweExpense.amount)"
        
        return cell
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
