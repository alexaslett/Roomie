//
//  CreateGroupViewController.swift
//  Roomie
//
//  Created by macbook pro on 9/21/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit
import CloudKit

class CreateGroupViewController: UIViewController {
    
    
    let group = GroupController()
    
    
    
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var groupNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenViewIsTapped()
        view.backgroundColor = UIColor.ivoryWhite60
        
    }

    @IBAction func generate(_ sender: Any) {
        let passcode = group.randomPassword(passwordLength: 6)
        codeTextField.isUserInteractionEnabled = false
        codeTextField.text = passcode
    }
    @IBAction func doneButtonTapped(_ sender: Any) {
        guard let groupName = groupNameTextField.text, let code = codeTextField.text, groupName != "", code != "" else { self.presentSimpleAlert(title: "Error Creating Group", message: "Please check that no fields are empty"); return }
        //navigationItem.rightBarButtonItem?.isEnabled = false
        GroupController.shared.createNewGroup(groupName: groupName, passcode: code) { (success) in
            if success {
                DispatchQueue.main.async {
                _ = self.navigationController?.popViewController(animated: true)
                }
            } else {
                // present an alertController saying to try and again
                DispatchQueue.main.async {
                self.presentSimpleAlert(title: "Error Creating Group", message: "Error creating group, please try again")
                }
            }
        }
        
        //_ = self.navigationController?.popViewController(animated: true)
    }
    
    func presentSimpleAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alertController.addAction(dismissAction)
        present(alertController, animated: true, completion: nil)
    }

    
    
}
