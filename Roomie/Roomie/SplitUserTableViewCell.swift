//
//  SplitUserTableViewCell.swift
//  Roomie
//
//  Created by Alex Aslett on 9/22/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class SplitUserTableViewCell: UITableViewCell {

    var user: User? {
        didSet {
            updateViews()
        }
    }
    
    var userIsSelected: Bool = true
    
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var isSelectedButton: UIButton!
    
    @IBAction func isSelectedButtonTapped(_ sender: Any){
        if userIsSelected {
            isSelectedButton.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
            userIsSelected = false
        } else {
            isSelectedButton.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
            userIsSelected = true
        }
    }
    
    func updateViews(){
        guard let user = user else { return }
        fullNameLabel.text = "\(user.firstName) \(user.lastName)"
    }
    
}
