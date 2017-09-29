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
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refetch), for: .valueChanged)
        
        tableView.refreshControl = refreshControl
        
        ExpenseController.shared.fetchOwedExpensesByGroup()
        ExpenseController.shared.fetchOweExpensesByGroup { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        self.view.backgroundColor = UIColor.ivoryWhite60
        self.tableView.backgroundColor = UIColor.clear
        
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        addNewExpenseButton.tintColor = UIColor.tealBlue30
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ExpenseController.shared.fetchOwedExpensesByGroup()
        ExpenseController.shared.fetchOweExpensesByGroup { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentSwitch: UISegmentedControl!
    @IBOutlet weak var addNewExpenseButton: UIButton!
    
    @IBAction func groupButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch segmentSwitch.selectedSegmentIndex {
        case 0:
            return ExpenseController.shared.oweExpenses.count
        case 1:
            return ExpenseController.shared.owedExpenses.count
        default:
            return 0
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch segmentSwitch.selectedSegmentIndex {
        case 0:
            guard let oweCell = tableView.dequeueReusableCell(withIdentifier: "oweExpenseCell", for: indexPath) as? oweExpenseTableViewCell else { return UITableViewCell() }
            let oweExpense = ExpenseController.shared.oweExpenses[indexPath.row]
            oweCell.oweExpense = oweExpense
            oweCell.updateTable()
            oweCell.layer.cornerRadius = 20
            return oweCell
        case 1:
            guard let owedCell = tableView.dequeueReusableCell(withIdentifier: "owedExpenseCell", for: indexPath) as? owedExpenseTableViewCell else { return UITableViewCell() }
            let owedExpense = ExpenseController.shared.owedExpenses[indexPath.row]
            owedCell.owedExpense = owedExpense
            owedCell.updateTable()
            owedCell.layer.cornerRadius = 20
            return owedCell
        default:
            return UITableViewCell()
        }
        
    }
    
    @objc func refetch(){
        ExpenseController.shared.fetchOwedExpensesByGroup()
        ExpenseController.shared.fetchOweExpensesByGroup { (success) in
            if success {
                ExpenseController.shared.fetchOwedExpensesByGroup(completion: { (_) in
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.tableView.refreshControl?.endRefreshing()
                    }
                })
            }
        }
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toOweMarkPaid" {
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let expense = ExpenseController.shared.oweExpenses[indexPath.row]
            let destinationVC = segue.destination as? MarkPaidViewController
            destinationVC?.expense = expense
        }
        if segue.identifier == "toOwedMarkPaid" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let expense = ExpenseController.shared.owedExpenses[indexPath.row]
            let destinationVC = segue.destination as? MarkPaidViewController
            destinationVC?.expense = expense
            destinationVC?.isOwed = true
        }
    }
    
    
}
