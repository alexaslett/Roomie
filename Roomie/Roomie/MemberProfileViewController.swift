//
//  MemberProfileViewController.swift
//  Roomie
//
//  Created by macbook pro on 9/27/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class MemberProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       self.view?.backgroundColor = UIColor.white.withAlphaComponent(0.5)
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
