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
    @IBOutlet weak var profileImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.ivoryWhite60

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let user = UserController.shared.currentUser else { return }
        firstNameTextfield.text = user.firstName
        lastNameTextfield.text = user.lastName
        emailTextfield.text = user.email
        phoneTextfield.text = user.phone
        
        profileImage.image = user.photo
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.layer.borderWidth = 2.0
        profileImage.clipsToBounds = true
        profileImage.layer.borderColor = UIColor.white.cgColor
    }
}
