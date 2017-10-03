//
//  GroupListViewController.swift
//  Roomie
//
//  Created by Alex Aslett on 9/22/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class GroupListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var viewBG: UIView!
    @IBOutlet weak var createGroupButton: UIButton!
    @IBOutlet weak var joinGroupButton: UIButton!
    @IBOutlet weak var groupTitleLabel: UILabel!
    
    // Cell Height
    let cellSpacingHeight: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Changing background colors
        view.backgroundColor = UIColor.ivoryWhite60
        self.tableView.backgroundColor = UIColor.clear
        
        createGroupButton.backgroundColor = UIColor.tealBlue30
        joinGroupButton.backgroundColor = UIColor.tealBlue30
        groupTitleLabel.textColor = UIColor.customLightGrey10
        
        self.tableView.separatorStyle = .none
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
        
        // Welcome in navigation
        guard let user = UserController.shared.currentUser?.firstName else { return }
        navigationController?.navigationBar.topItem?.title = "Welcome \(user)!"
        
        GroupController.shared.fetchGroupsForUser { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        GroupController.shared.fetchGroupsForUser { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return GroupController.shared.UsersGroups.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath)
        let group = GroupController.shared.UsersGroups[indexPath.section]
        cell.textLabel?.text = "\(group.groupName)"
        cell.detailTextLabel?.text = "Passcode: \(group.passcode)"
        
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.textColor = UIColor.white
        // add border and color
        cell.backgroundColor = UIColor.customLightGrey10
        //cell.layer.borderColor = UIColor.black.cgColor
        //cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        
        return cell
    }
    
    
    
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let group = GroupController.shared.UsersGroups[indexPath.section]
            
            if GroupController.shared.UsersGroups.count == 1 {
                showPopUp()
            } else {
                GroupController.shared.leaveGroup(group: group, completion: { (success) in
                    
                    if success {
                        GroupController.shared.fetchGroupsForUser(completion: { (success) in
                            DispatchQueue.main.async {
                                tableView.reloadData()
                            }
                        })
                    }
                })
            }
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTabBar" {
            guard let indexpath = tableView.indexPathForSelectedRow else { return }
            let group = GroupController.shared.UsersGroups[indexpath.section]
            // Fix me for MVC
            GroupController.shared.currentGroup = group
            
        }
    }
    
    func showPopUp() {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "toPopUp") as! PopOverViewController
        
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        //        popOverVC.modalPresentationStyle = .popover
        //
        //        present(popOverVC, animated: true, completion: nil)
    }
}
