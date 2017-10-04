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
        
        self.view.backgroundColor = UIColor.ivoryWhite60
        self.itemNameLabel.textColor = UIColor.black
        self.splitAmountLabel.textColor = UIColor.black
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
        let usersInGroupToSplitExpense = self.figureOutExpensePayees()
        let perPersonAmount = splitAmount1/Double(usersInGroupToSplitExpense.count)
        
        guard let payor = UserController.shared.currentUser?.cloudKitRecordID,
            let currentGroupCKRecordID = GroupController.shared.currentGroup?.cloudKitRecordID else { return }
        
        let payorRef = CKReference(recordID: payor, action: .none)
        let groupRef = CKReference(recordID: currentGroupCKRecordID, action: .none)
        guard let payorName = UserController.shared.currentUser?.firstName else { return }
        guard let itemTitle = itemName else { return }
        var expenseToBeSaved: [CKRecord] = []
        
        for x in 0..<usersInGroupToSplitExpense.count {
            guard let payeeID = usersInGroupToSplitExpense[x].cloudKitRecordID else { return }
            let payeeName = usersInGroupToSplitExpense[x].firstName
            let payeeRef = CKReference(recordID: payeeID, action: .none)
            if payeeID != UserController.shared.currentUser?.cloudKitRecordID {
                let expense = Expense(title: itemTitle, amount: perPersonAmount, payor: payorRef, payee: payeeRef, groupID: groupRef, payorName: payorName, payeeName: payeeName)
                let expenseCKRecord = CKRecord(expense)
                expense.cloudKitRecordID = expenseCKRecord.recordID
                
                //ExpenseController.shared.createExpense(title: itemTitle, amount: perPersonAmount, payor: payorRef, payee: payeeRef, groupID: groupRef, payorName: payorName, payeeName: payeeName, completion: { (success) in
                //})
                expenseToBeSaved.append(expenseCKRecord)
            }
        }
        
        ExpenseController.shared.saveMultipleExpenses(expenseToBeSaved) { (success) in
            if success {
                DispatchQueue.main.async {
                    let expenseSummeryVC = self.navigationController?.viewControllers[0] as! ExpenseSummaryViewController
                    self.navigationController?.popToViewController(expenseSummeryVC, animated: true)
                }
            } else {
                self.presentSimpleAlert(title: "Error Saving Expense", message: "Please try again")
            }
        }
        
    }
    
    
    
    
    func updateLabel() {
        guard let splitAmount1 = splitAmount, let itemName = itemName else { return }
        splitAmountLabel.text = "$\(String(format: "%.2f", splitAmount1))"
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
    
//    func presentExpenseSaved(){
//        let alert = UIAlertController(title: "Expense Saved", message: nil, preferredStyle: .alert)
//
//        let okAction = UIAlertAction(title: "Cool!", style: .default) { (_) in
//            let expenseSummeryVC = self.navigationController?.viewControllers[0] as! ExpenseSummaryViewController
//            self.navigationController?.popToViewController(expenseSummeryVC, animated: true)
//        }
//        alert.addAction(okAction)
//        present(alert, animated: true, completion: nil)
//    }
    
    func figureOutExpensePayees() -> [User] {
        var usersToSplitExpense: [User] = []
        let numberOfUsersInGroup = UserController.shared.usersInCurrentGroup.count
        for index in 0..<numberOfUsersInGroup {
            let indexPath = IndexPath(item: index, section: 0)
            guard let cell = tableView.cellForRow(at: indexPath) as? SplitUserTableViewCell else { return [] }
            if cell.userIsSelected == true {
                guard let user = cell.user else { return [] }
                usersToSplitExpense.append(user)
            }
        }
        return usersToSplitExpense
    }
    
    func presentSimpleAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
