//
//  MembersCollectionViewController.swift
//  Roomie
//
//  Created by macbook pro on 9/27/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit


class MembersCollectionViewController: UICollectionViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Find group with members inside
        guard let group = GroupController.shared.currentGroup else { return }
        UserController.shared.usersInGroup(group: group) { (_) in
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
        
        //self.collectionView?.gradientBackGround(colorOne: .blue, colorTwo: .purple)
    
        //self.navigationController?.navigationBar.backgroundColor = UIColor.clear

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        DispatchQueue.main.async {
//            self.collectionView?.reloadData()
//        }
    }
    
    @IBAction func groupsButtonTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
     // MARK: - Navigation
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toProfile" {
//
//            let destinationVC = segue.destination as? MemberProfileViewController
//            let selectedCell = sender as! MemberCollectionViewCell
//            let indexPath = collectionView?.indexPath(for: selectedCell)
//
//            let profile = UserController.shared.usersInCurrentGroup[indexPath!.row]
//
//            destinationVC?.profileName.text = "\(profile.firstName) \(profile.lastName)"
//            destinationVC?.phoneNumber.text = profile.phone
//            destinationVC?.emailLabel.text = profile.email
//        }
     }
 
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UserController.shared.usersInCurrentGroup.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemberCell", for: indexPath) as? MemberCollectionViewCell else { return UICollectionViewCell() }
        
        let member = UserController.shared.usersInCurrentGroup[indexPath.row]

        guard let first = member.firstName.characters.first,
            let last = member.lastName.characters.first
            else { return UICollectionViewCell() }

        cell.backgroundColor = UIColor.cyan
        cell.layer.cornerRadius = cell.frame.width / 2

        cell.updateCells(first: first, last: last)
        
        return cell
    }
    
    
    
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
