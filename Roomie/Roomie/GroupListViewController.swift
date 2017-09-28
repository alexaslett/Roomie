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
    
    // Cell Height
    let cellSpacingHeight: CGFloat = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Changing background colors
        self.viewBG.gradientBackGround(colorOne: .blue, colorTwo: .purple)
        self.tableView.backgroundColor = UIColor.clear
        
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
        
        // add border and color
        cell.backgroundColor = UIColor.white
        //cell.layer.borderColor = UIColor.black.cgColor
        //cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        
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
            let group = GroupController.shared.UsersGroups[indexpath.section]
            // Fix me for MVC
            GroupController.shared.currentGroup = group
            
        }
     }

    
}
