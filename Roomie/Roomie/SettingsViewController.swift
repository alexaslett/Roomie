//
//  SettingsViewController.swift
//  Roomie
//
//  Created by macbook pro on 9/24/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit
import Foundation

class SettingsViewController: UIViewController {

    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var aboutButton: UIButton!
    
    @IBOutlet var viewBG: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.ivoryWhite60
        
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        profileButton.backgroundColor = UIColor.tealBlue30
        contactButton.backgroundColor = UIColor.tealBlue30
        rateButton.backgroundColor = UIColor.tealBlue30
        aboutButton.backgroundColor = UIColor.tealBlue30
    }

    @IBAction func groupsButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension UIView {
    
    
    func gradientBackGround(colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }

    
}
