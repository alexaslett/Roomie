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
        
        self.title = task?.taskName
    }
    
    // MARK: - Actions
    
    @IBAction func taskCompletedButtonTapped(_ sender: UIButton) {
        guard let task = task else { return }
        TaskController.shared.deleteTask(task: task)
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let taskName = taskNameTextField.text, taskName != "", let ownerName = ownerNameTextField.text, ownerName != "", let owner = UserController.shared.currentUser?.appleUserRef, let group = TaskController.shared.task?.group else { return }
        
        if self.task == nil {
            TaskController.shared.createTask(taskName: taskName, owner: owner, ownerName: ownerName, isComplete: false, dueDate: dueDatePicker.date, group: group)
        } else {
            guard let task = self.task else { return }
            TaskController.shared.updateTask(task: task, owner: owner, ownerName: ownerName, isComplete: false, dueDate: dueDatePicker.date, group: group)
            updateViews()
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        guard let task = self.task, let ownerName = UserController.shared.currentUser?.firstName else { return }
        let dueDate = dueDatePicker.date
        
        taskNameTextField.text = task.taskName
        ownerNameTextField.text = ownerName
        dueDatePicker.date = dueDate
    }
}
