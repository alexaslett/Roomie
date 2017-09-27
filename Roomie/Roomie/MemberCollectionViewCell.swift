//
//  MemberCollectionViewCell.swift
//  Roomie
//
//  Created by macbook pro on 9/27/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class MemberCollectionViewCell: UICollectionViewCell {
    
    var membersCollection: User?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func updateCells() {
        
        guard let membersCollection = membersCollection else { return }
        
        //nameLabel.text = membersCollection.firstName.characters.first
        
    }
    
    
}
