//
//  TaskDetailViewController.swift
//  Roomie
//
//  Created by Kaitlyn Barker on 9/20/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit
import CloudKit

class TaskDetailViewController: UIViewController {
    
    var task: Task?
    
    // MARK: - Outlets
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var ownerNameTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var taskCompletedButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = task?.taskName
        self.updateViews()
        self.hideKeyboardWhenViewIsTapped()
    }
    
    // MARK: - Actions
    
    @IBAction func taskCompletedButtonTapped(_ sender: UIButton) {
        guard let task = task else { return }
        TaskController.shared.deleteTask(task: task)
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let taskName = taskNameTextField.text, taskName != "", let ownerName = ownerNameTextField.text, ownerName != "", let owner = UserController.shared.currentUser?.appleUserRef, let groupCKRecordID = GroupController.shared.currentGroup?.cloudKitRecordID else { return }
        
        let group = CKReference(recordID: groupCKRecordID, action: .deleteSelf)
        
        if self.task == nil {
            TaskController.shared.createTask(taskName: taskName, owner: owner, ownerName: ownerName, dueDate: dueDatePicker.date, group: group)
        } else {
            guard let task = self.task else { return }
            TaskController.shared.updateTasks(task: task, taskName: taskName, owner: owner, ownerName: ownerName, group: group)
            updateViews()
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        guard let task = self.task else { return }
        let dueDate = dueDatePicker.date
        
        taskNameTextField.text = task.taskName
        ownerNameTextField.text = task.ownerName
        dueDatePicker.date = dueDate
    }
}
