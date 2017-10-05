//
//  MemberCollectionViewCell.swift
//  Roomie
//
//  Created by macbook pro on 9/27/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class MemberCollectionViewCell: UICollectionViewCell {
    
    var user: User? {
        didSet {
            updateCells()
        }
    }
    

    @IBOutlet weak var memberLabel: UILabel!
    @IBOutlet weak var memberImage: UIImageView!
    
    
    func updateCells() {
        guard let user = user else { return }
        
        if user.photo != nil {
            memberImage.image = user.photo
            memberLabel.isHidden = true
        } else {
            guard let first = user.firstName.characters.first,
                let second = user.lastName.characters.first
                else { return }
            
            memberLabel.text = "\(first)\(second)"
        }
    }
    
    
}
