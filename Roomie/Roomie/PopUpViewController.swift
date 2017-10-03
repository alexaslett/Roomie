//
//  PopUpViewController.swift
//  Roomie
//
//  Created by Johnathan Pham on 10/3/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    static let shared = PopUpViewController()

    @IBOutlet weak var popUpLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
