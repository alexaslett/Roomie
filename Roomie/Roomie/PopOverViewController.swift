//
//  PopOverViewController.swift
//  Roomie
//
//  Created by Johnathan Pham on 10/3/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class PopOverViewController: UIViewController {
    
    @IBOutlet weak var popOverLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popOverLabel.text = "Sorry, must be in at least one group."
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        showAnimate()

    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }

    @IBAction func closeButtonTapped(_ sender: Any) {
        self.view.removeFromSuperview()
        //self.dismiss(animated: true, completion: nil)
        removeAnimate()
    }
    
    
}
