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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    

    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroupController.shared.UsersGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath)
        let group = GroupController.shared.UsersGroups[indexPath.row]
        cell.textLabel?.text = "\(group.groupName)"
        cell.detailTextLabel?.text = "\(group.passcode)"
        
        return cell
    }
    
    
    
    
//   // Override to support editing the table view.
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let group = GroupController.shared.groups[indexPath.row]
//            
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    

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

    
}
