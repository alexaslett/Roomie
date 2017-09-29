//
//  PostTableViewCell.swift
//  Roomie
//
//  Created by Kaitlyn Barker on 9/28/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var bubbleView: UIView!
    
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let post = post else { return }
        
        self.backgroundColor = UIColor.blue30
        
        if post.authorUserName == UserController.shared.currentUser?.firstName {
            bubbleView.backgroundColor = UIColor.blue10
        } else {
            bubbleView.backgroundColor = UIColor.blue60
        }
        
        bubbleView.layer.cornerRadius = 8
        authorNameLabel.textColor = .darkGray
        authorNameLabel.text = post.authorUserName
        postTextLabel.textColor = .white
        postTextLabel.text = post.text
        postTextLabel.preferredMaxLayoutWidth = self.frame.width - 32
    }
}
