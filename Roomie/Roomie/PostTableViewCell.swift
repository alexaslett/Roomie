//
//  PostTableViewCell.swift
//  Roomie
//
//  Created by Kaitlyn Barker on 9/28/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    var post: Post? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    
    // MARK: - Chat bubbles
    
    func stretchBubbleImage2(image: UIImage) {
        
    }
    
    func stretchBubbleImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio = targetSize.width / image.size.width
        let heightRatio = targetSize.height / image.size.height
        var newSize: CGSize
        
        if (widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        image.draw(in: rect)
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func updateViews() {
        guard let post = self.post else { return }
        
        postLabel.text = post.text
        authorNameLabel.text = post.authorUserName
        postLabel.backgroundColor = UIColor.gray
        postLabel.layer.borderColor = UIColor.black.cgColor
        postLabel.layer.borderWidth = 2
        postLabel.layer.cornerRadius = postLabel.frame.size.height / 2
        postLabel.clipsToBounds = true
    }
}
