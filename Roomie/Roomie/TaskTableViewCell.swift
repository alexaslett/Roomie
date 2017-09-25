//
//  TaskTableViewCell.swift
//  Roomie
//
//  Created by Kaitlyn Barker on 9/20/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    weak var delegate: TaskTableViewCellDelegate?
    
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
        
        ownerNameLabel.text = task.ownerName
        taskNameLabel.text = task.taskName
        dueDateLabel.text = date.string(from: task.dueDate)
    }
}

protocol TaskTableViewCellDelegate: class {
    func taskWasCreated(cell: TaskTableViewCell)
}
