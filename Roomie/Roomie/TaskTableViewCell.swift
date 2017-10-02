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
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var labelStackView: UIStackView!
    
    func updateViews() {
        guard let task = self.task, let date = task.dueDate.formatter else { return }
        
        ownerNameLabel.textColor = UIColor.darkGray
        taskNameLabel.textColor = UIColor.white
        dueDateLabel.textColor = UIColor.white
        bubbleView.backgroundColor = UIColor.tealBlue30
        
        ownerNameLabel.text = "Owner: \(task.ownerName)"
        taskNameLabel.text = "Task: \(task.taskName)"
        dueDateLabel.text = "Due: \(date.string(from: task.dueDate))"
        
        bubbleView.layer.cornerRadius = 8
        taskNameLabel.preferredMaxLayoutWidth = self.frame.width - 32
        dueDateLabel.preferredMaxLayoutWidth = self.frame.width - 32
    }
}
