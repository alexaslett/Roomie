//
//  PostDetailViewController.swift
//  Roomie
//
//  Created by Kaitlyn Barker on 9/20/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var messageTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
    }
}
