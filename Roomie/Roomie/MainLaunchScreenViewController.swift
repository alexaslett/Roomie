//
//  MainLaunchScreenViewController.swift
//  Roomie
//
//  Created by Alex Aslett on 9/26/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class MainLaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UserController.shared.fetchCurrentUser { (_) in
            if UserController.shared.currentUser != nil {
                let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavGroupList") as! UINavigationController
                self.present(storyboard, animated: true, completion: nil)
            } else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LaunchScreenViewController") as! LaunchScreenViewController
                self.present(storyboard, animated: true, completion: nil)
            }
        }
        
    }


}
