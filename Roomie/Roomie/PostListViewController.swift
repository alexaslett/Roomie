//
//  PostListViewController.swift
//  Roomie
//
//  Created by Kaitlyn Barker on 9/20/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit
import CloudKit

class PostListViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var postListTableView: UITableView!
    @IBOutlet weak var postTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        
//        guard let authorCKRecordID = UserController.shared.currentUser?.cloudKitRecordID else { return }
//
//        let authorReference = CKReference(recordID: authorCKRecordID, action: .deleteSelf)
//
//        PostController.shared.createPost(author: authorReference, group: <#T##CKReference#>, text: <#T##String#>, completion: <#T##((Error?) -> Void)##((Error?) -> Void)##(Error?) -> Void#>)
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostController.shared.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        
        guard let firstName = UserController.shared.currentUser?.firstName else { return UITableViewCell() }
        
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
