//
//  LaunchScreenViewController.swift
//  Roomie
//
//  Created by Alex Aslett on 9/20/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit
import CloudKit

class LaunchScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfICloudIsAvailabe()
        
    }
    
    @IBOutlet weak var signUpButton: UIButton!
    
    func checkIfICloudIsAvailabe(){
        CKContainer.default().accountStatus { (accountStat, error) in
            if case .available = accountStat {
                print("iCloud is available")
            } else {
                self.signUpButton.isHidden = true
                self.presentNoICloudAccount()
            }
        }
    }
    func presentNoICloudAccount(){
        let alert = UIAlertController(title: "No iCloud Account Detected", message: "Please check your settings and make sure you are logged into iCloud", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
}
