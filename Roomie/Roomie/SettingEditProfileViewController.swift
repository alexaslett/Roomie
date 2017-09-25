//
//  SettingEditProfileViewController.swift
//  Roomie
//
//  Created by macbook pro on 9/24/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class SettingEditProfileViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var lastNameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var phoneTextfield: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let user = UserController.shared.currentUser else { return }
        firstNameTextfield.text = user.firstName
        lastNameTextfield.text = user.lastName
        emailTextfield.text = user.email
        phoneTextfield.text = user.phone
        
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let user = UserController.shared.currentUser,
            let firstName = firstNameTextfield.text,
            let lastName = lastNameTextfield.text,
            let email = emailTextfield.text,
            let phone = phoneTextfield.text
        else { return }
        
        UserController.shared.editProfile(firstName: firstName, lastName: lastName, email: email, phone: phone, user: user) { (success) in
            
        }
        navigationController?.popViewController(animated: true)
    }
    
    
}
