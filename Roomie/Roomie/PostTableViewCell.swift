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
        
        postLabel.textColor = .white
        postLabel.text = post.text
        authorNameLabel.text = post.authorUserName
        postLabel.backgroundColor = UIColor.blue30
//        postLabel.layer.borderColor = UIColor.black.cgColor
//        postLabel.layer.borderWidth = 2
//        postLabel.layer.cornerRadius = postLabel.frame.size.height / 2
        postLabel.clipsToBounds = true
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
