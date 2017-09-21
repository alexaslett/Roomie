//
//  TaskDetailViewController.swift
//  Roomie
//
//  Created by Kaitlyn Barker on 9/20/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    var task: Task?
    
    // MARK: - Outlets
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var ownerNameTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var taskCompletedButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func taskCompletedButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
    }
}
