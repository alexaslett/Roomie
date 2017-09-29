//
//  MemberCollectionViewCell.swift
//  Roomie
//
//  Created by macbook pro on 9/27/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class MemberCollectionViewCell: UICollectionViewCell {
    
    var user: User?

    @IBOutlet weak var memberLabel: UILabel!
    
    
    func updateCells(first: Character, last: Character) {
        
        let nameIntial = "\(first)\(last)"
        
        memberLabel.text = nameIntial
    }
    
    
}
