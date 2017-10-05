//
//  SettingsViewController.swift
//  Roomie
//
//  Created by macbook pro on 9/24/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit
import Foundation

class SettingsViewController: UIViewController  {
    
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
        
        profileButton.layer.shadowColor = UIColor.black.cgColor
        profileButton.layer.shadowRadius = 2
        profileButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        profileButton.layer.shadowOpacity = 0.5
        
        contactButton.layer.shadowColor = UIColor.black.cgColor
        contactButton.layer.shadowRadius = 2
        contactButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        contactButton.layer.shadowOpacity = 0.5
        
        rateButton.layer.shadowColor = UIColor.black.cgColor
        rateButton.layer.shadowRadius = 2
        rateButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        rateButton.layer.shadowOpacity = 0.5
        
        aboutButton.layer.shadowColor = UIColor.black.cgColor
        aboutButton.layer.shadowRadius = 2
        aboutButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        aboutButton.layer.shadowOpacity = 0.5
    }
    
    @IBAction func groupsButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rateButtonTapped(_ sender: Any) {
        rateButtonAlert()
    }
    
    
    func rateButtonAlert() {
        let alert = UIAlertController(title: "Rate Us", message: "Do you enjoy Roomie? \nPlease rate us in the App Store.", preferredStyle: .alert)
        
        //        let alertAction = UIAlertAction(title: "Rate us", style: .default) { (_) in
        //            let settingVC = self.navigationController?.viewControllers[0] as! SettingsViewController
        //            self.navigationController?.popToViewController(settingVC, animated: true)
        //        }
        //        let alertActionNotNow = UIAlertAction(title: "Not now", style: .cancel) { (_) in
        //            let settingVC = self.navigationController?.viewControllers[0] as! SettingsViewController
        //            self.navigationController?.popToViewController(settingVC, animated: true)
        //        }
        //        alert.addAction(alertAction)
        //        alert.addAction(alertActionNotNow)
        let alertAction = UIAlertAction(title: "Close", style: .default) { (_) in
            let settingVC = self.navigationController?.viewControllers[0] as! SettingsViewController
            self.navigationController?.popToViewController(settingVC, animated: true)
        }
        alert.addAction(alertAction)
        present(alert, animated:  true, completion: nil)
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
