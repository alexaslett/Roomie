//
//  SplitExpensesViewController.swift
//  Roomie
//
//  Created by Alex Aslett on 9/22/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit
import CloudKit

class SplitExpensesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //FIXME: Might need to unwrap the currentGroup first to get rid of this bang
        UserController.shared.usersInGroup(group: GroupController.shared.currentGroup!) { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        updateLabel()
        
        self.view.gradientBackGround(colorOne: .blue, colorTwo: .purple)
        self.itemNameLabel.textColor = UIColor.white
        self.splitAmountLabel.textColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var splitAmountLabel: UILabel!
    var splitAmount: Double?
    var itemName: String?
    let expenseWasSaved = Notification.Name("expenseWasSaved")
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let splitAmount1 = splitAmount
            else { return }
        let usersInGroupCnt = UserController.shared.usersInCurrentGroup.count
        let perPersonAmount = splitAmount1/Double(usersInGroupCnt)
        
        guard let payor = UserController.shared.currentUser?.cloudKitRecordID,
            let currentGroupCKRecordID = GroupController.shared.currentGroup?.cloudKitRecordID else { return }
        
        let payorRef = CKReference(recordID: payor, action: .none)
        let groupRef = CKReference(recordID: currentGroupCKRecordID, action: .none)
        guard let payorName = UserController.shared.currentUser?.firstName else { return }
        guard let itemTitle = itemName else { return }
        
        for x in 0..<usersInGroupCnt {
            guard let payeeID = UserController.shared.usersInCurrentGroup[x].cloudKitRecordID else { return }
            let payeeName = UserController.shared.usersInCurrentGroup[x].firstName
            let payeeRef = CKReference(recordID: payeeID, action: .none)
            if payeeID != UserController.shared.currentUser?.cloudKitRecordID {
            ExpenseController.shared.createExpense(title: itemTitle, amount: perPersonAmount, payor: payorRef, payee: payeeRef, groupID: groupRef, payorName: payorName, payeeName: payeeName, completion: { (success) in
            })
            }
        }
        
//        let expenseSummeryVC = self.navigationController?.viewControllers[0] as! ExpenseSummaryViewController
//        self.navigationController?.popToViewController(expenseSummeryVC, animated: true)
        presentExpenseSaved()
    }
    
   
    
    
    func updateLabel() {
        guard let splitAmount1 = splitAmount, let itemName = itemName else { return }
        splitAmountLabel.text = "\(splitAmount1)"
        itemNameLabel.text = itemName
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserController.shared.usersInCurrentGroup.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? SplitUserTableViewCell else { return UITableViewCell() }
        let user = UserController.shared.usersInCurrentGroup[indexPath.row]
        cell.user = user
        return cell
    }
    
    func presentExpenseSaved(){
        let alert = UIAlertController(title: "Expense Saved", message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Cool!", style: .default) { (_) in
            let expenseSummeryVC = self.navigationController?.viewControllers[0] as! ExpenseSummaryViewController
            self.navigationController?.popToViewController(expenseSummeryVC, animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}
