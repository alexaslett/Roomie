//
//  MemberProfileViewController.swift
//  Roomie
//
//  Created by macbook pro on 9/27/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class MemberProfileViewController: UIViewController {

    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var member: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view?.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
        
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateViews() {
        guard let member = member else { return }
        profileName.text = "\(member.firstName) \(member.lastName)"
        phoneNumber.text = member.phone
        emailLabel.text = member.email
    }
    
}
