//
//  SettingProfileViewController.swift
//  Roomie
//
//  Created by macbook pro on 9/24/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class SettingProfileViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var lastNameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var phoneTextfield: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.gradientBackGround(colorOne: .blue, colorTwo: .purple)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let user = UserController.shared.currentUser else { return }
        firstNameTextfield.text = user.firstName
        lastNameTextfield.text = user.lastName
        emailTextfield.text = user.email
        phoneTextfield.text = user.phone
    }
    
}
