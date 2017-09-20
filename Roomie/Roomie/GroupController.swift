//
//  GroupController.swift
//  Roomie
//
//  Created by macbook pro on 9/20/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit
import GameKit

class GroupController {
    
    let pwCharacters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","1","2","3","4","5","6","7","8","9","0","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y"]
    
    func randomPassword(passwordLength: Int) -> String {
        var password = ""
        let arrayCount = UInt32(pwCharacters.count)
        for _ in 0 ..< passwordLength {
            let randomNumber = Int(arc4random_uniform(arrayCount))
            password += pwCharacters[randomNumber]
        }
        return password
    }
    
}

