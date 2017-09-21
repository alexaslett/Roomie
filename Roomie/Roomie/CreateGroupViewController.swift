//
//  CreateGroupViewController.swift
//  Roomie
//
//  Created by macbook pro on 9/21/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class CreateGroupViewController: UIViewController {
    
    let group = GroupController()
    
    @IBOutlet weak var codeTextField: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func generate(_ sender: Any) {
        let passcode = group.randomPassword(passwordLength: 6)
        codeTextField.isUserInteractionEnabled = false
        codeTextField.text = passcode
    }
    
    
}
