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

extension UIColor {
    class var blue60: UIColor {
        return UIColor(hex: "4593B3")
    }
    
    class var blue30: UIColor {
        return UIColor(hex: "1C2848")
    }
    
    class var blue10: UIColor {
        return UIColor(hex: "6FC4D6")
    }
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(red: CGFloat(r) / 0xff, green: CGFloat(g) / 0xff, blue: CGFloat(b) / 0xff, alpha: 1)
    }
}
