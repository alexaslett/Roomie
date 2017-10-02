//
//  JoinGroupViewController.swift
//  Roomie
//
//  Created by macbook pro on 9/22/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit
import CloudKit

class JoinGroupViewController: UIViewController {

    @IBOutlet weak var passcodeTextfield: UITextField!
    @IBOutlet weak var joinGroupButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GroupController.shared.fetchAllGroups()
        hideKeyboardWhenViewIsTapped()

        view.backgroundColor = UIColor.ivoryWhite60
        joinGroupButton.backgroundColor = UIColor.tealBlue30

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GroupController.shared.fetchAllGroups()
    }
    
    @IBAction func joinButtonTapped(_ sender: Any) {
        
        
        
        guard let passcode = passcodeTextfield.text, passcode != "" else { return }
        var success: Bool = false
        for x in 0..<GroupController.shared.groups.count {
            if GroupController.shared.groups[x].passcode == passcode {
                let record = CKRecord(group: GroupController.shared.groups[x])
                GroupController.shared.addGroupRefToUser(record: record)
                success = true
            }
        }
        if success {
            // navigate back to the group list screen
            self.dismiss(animated: true, completion: nil)
        } else {
            // present error alert controller
            presentSimpleAlert(title: "Not Found", message: "That group could not be found, check your code and try again")
        }
        
    }
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func presentSimpleAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
