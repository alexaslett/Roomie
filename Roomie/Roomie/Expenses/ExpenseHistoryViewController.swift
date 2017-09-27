//
//  ExpenseHistoryViewController.swift
//  Roomie
//
//  Created by Alex Aslett on 9/27/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class ExpenseHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refetch), for: .valueChanged)
        
        tableView.refreshControl = refreshControl
        
        ExpenseController.shared.fetchOthersPaidExpensesByGroup()
        ExpenseController.shared.fetchPaidExpensesByGroup { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ExpenseController.shared.fetchOthersPaidExpensesByGroup()
        ExpenseController.shared.fetchPaidExpensesByGroup { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedController.selectedSegmentIndex {
        case 0:
            return ExpenseController.shared.paidExpenses.count
        case 1:
            return ExpenseController.shared.othersPaidExpenses.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch segmentedController.selectedSegmentIndex {
        case 0:
            guard let youPaidCell = tableView.dequeueReusableCell(withIdentifier: "youPaidCell", for: indexPath) as? PaidOthersTableViewCell else { return UITableViewCell() }
            let youPaidExpense = ExpenseController.shared.paidExpenses[indexPath.row]
            youPaidCell.expense = youPaidExpense
            youPaidCell.updateYouPaidCell()
            return youPaidCell
        case 1:
            guard let werePaidCell = tableView.dequeueReusableCell(withIdentifier: "werePaidCell", for: indexPath) as? WerePaidTableViewCell else { return UITableViewCell() }
            let werePaidExpense = ExpenseController.shared.othersPaidExpenses[indexPath.row]
            werePaidCell.expense = werePaidExpense
            werePaidCell.updateWerePaidCell()
            return werePaidCell
        default:
            return UITableViewCell()
        }
    }
 

    @objc func refetch(){
        ExpenseController.shared.fetchOthersPaidExpensesByGroup()
        ExpenseController.shared.fetchPaidExpensesByGroup { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.tableView.refreshControl?.endRefreshing()
                }
            }
        }
        
        
    }
    

}
