//
//  TaskTableViewCell.swift
//  Roomie
//
//  Created by Kaitlyn Barker on 9/20/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    var task: Task? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    func updateViews() {
        guard let task = self.task, let date = task.dueDate.formatter else { return }
        
        ownerNameLabel.textColor = .white
        taskNameLabel.textColor = .white
        dueDateLabel.textColor = .white
        
        ownerNameLabel.text = "Owner: \(task.ownerName)"
        taskNameLabel.text = "Task: \(task.taskName)"
        dueDateLabel.text = "Due: \(date.string(from: task.dueDate))"
    }
}
