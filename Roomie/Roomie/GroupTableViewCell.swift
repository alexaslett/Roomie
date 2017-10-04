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
    
    var group: Group? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    func updateViews() {
        
    }
}
