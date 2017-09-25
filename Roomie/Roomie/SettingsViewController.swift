//
//  SettingsViewController.swift
//  Roomie
//
//  Created by macbook pro on 9/24/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var aboutButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProfile" {
            
        }
    }

}
