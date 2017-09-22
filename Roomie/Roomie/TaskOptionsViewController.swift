//
//  TaskOptionsViewController.swift
//  Roomie
//
//  Created by Kaitlyn Barker on 9/20/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class TaskOptionsViewController: UIViewController {
    
    // MARK: - might not even need this view controller
    
    // MARK: - Outlets
    
    @IBOutlet weak var choresButton: UIButton!
    @IBOutlet weak var shoppingListButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func choresButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func shoppingListButtonTapped(_ sender: UIButton) {
        
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
