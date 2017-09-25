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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBOutlet weak var splitAmountLabel: UILabel!
    var splitAmount: Double?
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        guard let splitAmount1 = splitAmount else { return }
        let usersInGroupCnt = UserController.shared.usersInCurrentGroup.count
        let perPersonAmount = splitAmount1/Double(usersInGroupCnt)
        
        guard let payor = UserController.shared.currentUser?.cloudKitRecordID,
            let currentGroupCKRecordID = GroupController.shared.currentGroup?.cloudKitRecordID else { return }
        
        let payorRef = CKReference(recordID: payor, action: .none)
        let groupRef = CKReference(recordID: currentGroupCKRecordID, action: .none)
        
        
        for x in 0..<usersInGroupCnt {
            guard let payeeID = UserController.shared.usersInCurrentGroup[x].cloudKitRecordID else { return }
            let payeeRef = CKReference(recordID: payeeID, action: .none)
            ExpenseController.shared.createExpense(title: "Another thing", amount: perPersonAmount, payor: payorRef, payee: payeeRef, groupID: groupRef, completion: { (success) in
                //might need somthing here
            })
        }
        
        
    }
    func updateLabel() {
        guard let splitAmount1 = splitAmount else { return }
        splitAmountLabel.text = "\(splitAmount1)"
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
