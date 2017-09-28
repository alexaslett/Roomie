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
    @IBOutlet weak var postStackView: UIStackView!
    @IBOutlet weak var stackViewsView: UIView!
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var superviewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PostController.shared.fetchPostsByGroup { (success) in
            if success {
                DispatchQueue.main.async {
                    self.postListTableView.reloadData()
                }
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        self.hideKeyboardWhenViewIsTapped()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Actions
    
    @IBAction func groupsButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        
        guard let authorCKRecordID = UserController.shared.currentUser?.cloudKitRecordID,
            let authorName = UserController.shared.currentUser?.firstName,
            let currentGroupCKRecordID = GroupController.shared.currentGroup?.cloudKitRecordID,
            let postText = postTextField.text, postText != "" else { return }

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
                    self.postTextField.resignFirstResponder()
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostController.shared.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        
        let post = PostController.shared.posts[indexPath.row]
        
        cell.post = post
        
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
    
    // MARK: - Keyboard functions
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration: TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve: UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            guard let tabBarHeight = tabBarController?.tabBar.frame.size.height else { return }
            
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.superviewBottomConstraint.constant = tabBarHeight
            } else {
                self.superviewBottomConstraint.constant = endFrame?.size.height ?? 8.0
            }
            
            UIView.animate(withDuration: duration, delay: TimeInterval(0), options: animationCurve, animations: {
                self.view.layoutIfNeeded() }, completion: nil)
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenViewIsTapped() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
