//
//  SignUpTableViewController.swift
//  Roomie
//
//  Created by Alex Aslett on 9/20/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class SignUpTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let firstName = firstNameField.text, firstName != "", let lastName = lastNameField.text, lastName != "", let email = emailField.text, email != "", let phone = phoneNumberField.text else { self.presentSimpleAlert(title: "Unable to create an account", message: "Be sure you entered a vaild email and username, try again")
            return
        }
        
        // activityIndicator.startAnimating()
        
        UserController.shared.createUserWith(firstName: firstName, lastName: lastName, email: email, phone: phone) { (success) in
            if !success {
                DispatchQueue.main.async {
                    self.presentSimpleAlert(title: "Unable to create an account", message: "Make sure you have a network connection, and please try again.")
                    
                }
            }
        }
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func segueToGroupVC() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "toGroupScreen", sender: self)
        }
    }
    
    func presentSimpleAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
