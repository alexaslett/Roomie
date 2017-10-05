//
//  SettingsContactUsTableViewController.swift
//  Roomie
//
//  Created by macbook pro on 9/25/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit
import MessageUI

class SettingsContactUsTableViewController: UITableViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var subjectTextfield: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let paddingView = UIView(frame: CGRect(x: 0, y: 5, width: self.nameTextfield.frame.width, height: self.nameTextfield.frame.height))
//        nameTextfield. = paddingView
//        nameTextfield.leftViewMode = .always
        
        nameTextfield.delegate = self
        subjectTextfield.delegate = self
        messageTextView.delegate = self
        
        
        
        
    }


    func textViewDidBeginEditing(_ textView: UITextView) {
        messageTextView.text = ""
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextfield.resignFirstResponder()
        subjectTextfield.resignFirstResponder()
        messageTextView.resignFirstResponder()
        return true
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            
            let mailVC = MFMailComposeViewController()
            mailVC.mailComposeDelegate = self
            mailVC.setSubject(subjectTextfield.text!)
            mailVC.setMessageBody(messageTextView.text!, isHTML: false)
            mailVC.setToRecipients(["oneroundtech@gmail.com"])
            
            self.present(mailVC, animated: true, completion: nil)
        } else {
            print("This device cannot send emails.")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result {
        case .sent:
            navigationController?.popViewController(animated: true)
        case .saved:
            navigationController?.popViewController(animated: true)
        case .failed:
            sentEmailErrorAlert()
        case .cancelled:
            print("Cancelled mail")
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    func sentEmailErrorAlert() {
        
        let emailErrorAlert = UIAlertView(title: "Could not send email.", message: "Your device could not send email. Please check e-mail configuration and try again", delegate: self, cancelButtonTitle: "OK")
        emailErrorAlert.show()
        
    }
    
}













