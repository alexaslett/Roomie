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
    @IBOutlet weak var createGroupButton: UIButton!
    @IBOutlet weak var joinGroupButton: UIButton!
    @IBOutlet weak var groupTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Changing background colors
        view.backgroundColor = UIColor.ivoryWhite60
        self.tableView.backgroundColor = UIColor.ivoryWhite60
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 60
        self.tableView.separatorStyle = .none
        
        createGroupButton.backgroundColor = UIColor.tealBlue30
        joinGroupButton.backgroundColor = UIColor.tealBlue30
        groupTitleLabel.textColor = UIColor.customLightGrey10
        
        createGroupButton.titleLabel?.font = UIFont.americanTypewriter
        joinGroupButton.titleLabel?.font = UIFont.americanTypewriter
        groupTitleLabel.font = UIFont.americanTypewriter
        
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
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroupController.shared.UsersGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupTableViewCell else { return UITableViewCell() }
        
        let group = GroupController.shared.UsersGroups[indexPath.row]
        
        cell.group = group
        
        return cell
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let group = GroupController.shared.UsersGroups[indexPath.row]
            
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
            let group = GroupController.shared.UsersGroups[indexpath.row]
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
