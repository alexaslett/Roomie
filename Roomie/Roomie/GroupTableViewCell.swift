//
//  GroupTableViewCell.swift
//  Roomie
//
//  Created by Kaitlyn Barker on 10/4/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var groupNameLabel: UILabel!
    
    var group: Group? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    func updateViews() {
        guard let group = self.group else { return }
        
        self.backgroundColor = UIColor.ivoryWhite60
        groupNameLabel.textColor = UIColor.white
        bubbleView.backgroundColor = UIColor.customLightGrey10
        
        bubbleView.layer.cornerRadius = 8
        groupNameLabel.text = group.groupName
        groupNameLabel.font = UIFont.biggerAmericanTypewriter
    }
}
