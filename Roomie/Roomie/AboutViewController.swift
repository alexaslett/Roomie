//
//  AboutViewController.swift
//  Roomie
//
//  Created by macbook pro on 9/27/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var aboutTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.aboutTextView.backgroundColor = UIColor.clear
        
        self.view.gradientBackGround(colorOne: .blue, colorTwo: .purple)
    }


}
