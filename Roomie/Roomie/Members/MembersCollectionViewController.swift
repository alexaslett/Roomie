//
//  MembersCollectionViewController.swift
//  Roomie
//
//  Created by macbook pro on 9/27/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit


class MembersCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Find group with members inside
        guard let group = GroupController.shared.currentGroup else { return }
        UserController.shared.usersInGroup(group: group) { (_) in
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }

        self.collectionView?.backgroundView?.backgroundColor = UIColor.ivoryWhite60
        
        //self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
        collectionView?.delegate = self
        
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
        if segue.identifier == "toProfile" {
            
            guard let destinationVC = segue.destination as? MemberProfileViewController,
//                let selectedCell = sender as? MemberCollectionViewCell,
//                let indexPath = self.collectionView?.indexPath(for: selectedCell)
                let indexPath = collectionView?.indexPathsForSelectedItems?.first
                else { return }
            
            let member = UserController.shared.usersInCurrentGroup[indexPath.item]
            
            destinationVC.member = member
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // number of Col.
        let nbCol = 3
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(nbCol - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(nbCol))
        return CGSize(width: size, height: size)
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

        cell.backgroundColor = UIColor.tealBlue30
        cell.layer.cornerRadius = cell.frame.width / 2

        cell.updateCells(first: first, last: last)
        
        return cell
    }
    
    
    
    
}