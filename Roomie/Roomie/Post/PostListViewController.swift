//
//  PostListViewController.swift
//  Roomie
//
//  Created by Kaitlyn Barker on 9/20/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit
import CloudKit

class PostListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets
    
    @IBOutlet weak var postListTableView: UITableView!
    @IBOutlet weak var postTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        PostController.shared.fetchPostsByGroup { (success) in
            if success {
                DispatchQueue.main.async {
                    self.postListTableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PostController.shared.fetchPostsByGroup { (success) in
            if success {
                DispatchQueue.main.async {
                    self.postListTableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        
        guard let authorCKRecordID = UserController.shared.currentUser?.cloudKitRecordID,
            let authorName = UserController.shared.currentUser?.firstName,
            let currentGroupCKRecordID = GroupController.shared.currentGroup?.cloudKitRecordID,
            let postText = postTextField.text else { return }

        let authorReference = CKReference(recordID: authorCKRecordID, action: .deleteSelf)

        let groupReference = CKReference(recordID: currentGroupCKRecordID, action: .deleteSelf)
        
        PostController.shared.createPost(author: authorReference, authorUserName: authorName, group: groupReference, text: postText) { (error) in
            
            if let error = error {
                NSLog("unable to create post \(error.localizedDescription)")
                return
            } else {
                DispatchQueue.main.async {
                    self.postListTableView.reloadData()
                    self.postTextField.text = ""
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostController.shared.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        
        let firstName = PostController.shared.posts[indexPath.row].authorUserName 
        
        let post = PostController.shared.posts[indexPath.row]
        
        post.authorUserName = firstName
        
        cell.textLabel?.text = post.authorUserName
        cell.detailTextLabel?.text = post.text
        
        return cell
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let post = PostController.shared.posts[indexPath.row]
            PostController.shared.deletePost(post: post)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}