//
//  GroupListViewController.swift
//  Roomie
//
//  Created by Alex Aslett on 9/22/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class GroupListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var user: User?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var createGroupButton: UIButton!
    @IBOutlet weak var joinGroupButton: UIButton!
    @IBOutlet weak var groupTitleLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    
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
        
        createGroupButton.layer.shadowColor = UIColor.black.cgColor
        createGroupButton.layer.shadowRadius = 2
        createGroupButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        createGroupButton.layer.shadowOpacity = 0.5
        
        joinGroupButton.layer.shadowColor = UIColor.black.cgColor
        joinGroupButton.layer.shadowRadius = 2
        joinGroupButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        joinGroupButton.layer.shadowOpacity = 0.5
        
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
        
        userImage()
        
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
    
    func userImage() {
        
        guard let user = UserController.shared.currentUser else { return }

        if user.photo != nil {
            profileImage.image = user.photo
            nameLabel.isHidden = true
            profileImage.layer.borderColor = UIColor.black.cgColor
            profileImage.layer.borderWidth = 2
        } else {
            nameLabel.textColor = UIColor.white
            nameLabel.backgroundColor = UIColor.tealBlue30
            nameLabel.layer.masksToBounds = true
            
            nameLabel.layer.shadowColor = UIColor.black.cgColor
            nameLabel.layer.shadowRadius = 2
            nameLabel.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            nameLabel.layer.shadowOpacity = 0.5
            nameLabel.layer.cornerRadius = nameLabel.frame.width / 2

            
            guard let first = user.firstName.characters.first,
                let last = user.lastName.characters.first
                else { return }
            
            nameLabel.text = "\(first)\(last)"
        }
        
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroupController.shared.UsersGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupTableViewCell else { return UITableViewCell() }
        
        let group = GroupController.shared.UsersGroups[indexPath.row]
        
        cell.contentView.layer.shadowColor = UIColor.black.cgColor
        cell.contentView.layer.shadowRadius = 2
        cell.contentView.layer.shadowOffset = CGSize(width: 2, height: 2)
        cell.contentView.layer.shadowOpacity = 0.7
        cell.contentView.clipsToBounds = true
        cell.contentView.layer.masksToBounds = true
        
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
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Leave"
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
