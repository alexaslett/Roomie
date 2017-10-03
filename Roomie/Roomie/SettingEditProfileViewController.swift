//
//  SettingEditProfileViewController.swift
//  Roomie
//
//  Created by macbook pro on 9/24/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import UIKit

class SettingEditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var lastNameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var phoneTextfield: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let user = UserController.shared.currentUser else { return }
        firstNameTextfield.text = user.firstName
        lastNameTextfield.text = user.lastName
        emailTextfield.text = user.email
        phoneTextfield.text = user.phone
        profileImage.image = user.photo
        
        picker.delegate = self
        
        
        hideKeyboardWhenViewIsTapped()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.layer.borderWidth = 2.0
        profileImage.clipsToBounds = true
        profileImage.layer.borderColor = UIColor.white.cgColor
    }
    
    let picker = UIImagePickerController()
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let user = UserController.shared.currentUser,
            let firstName = firstNameTextfield.text,
            let lastName = lastNameTextfield.text,
            let email = emailTextfield.text,
            let phone = phoneTextfield.text,
            let userPhoto = profileImage.image
        else { return }
        
        UserController.shared.editProfile(firstName: firstName, lastName: lastName, email: email, phone: phone, user: user, photo: userPhoto) { (success) in
            
        }
        navigationController?.popViewController(animated: true)
    }
    @IBAction func selectImageButtonTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Select Photo Location", message: nil, preferredStyle: .actionSheet)
        
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) -> Void in
                self.picker.sourceType = .photoLibrary
                self.present(self.picker, animated: true, completion: nil)
            }))
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            alert.addAction(UIAlertAction(title: "Camarea", style: .default, handler: { (_) -> Void in
                self.picker.sourceType = .camera
                self.present(self.picker, animated: true, completion: nil)
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Delegates
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let profilePic = info[UIImagePickerControllerOriginalImage] as! UIImage
        profileImage.contentMode = .scaleAspectFit
        profileImage.image = profilePic.resizeImage(image: profilePic)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension UIImage {
    
    func resizeImage(image: UIImage) -> UIImage {
        var actualHeight: Float = Float(image.size.height)
        var actualWidth: Float = Float(image.size.width)
        let maxHeight: Float = 200.0
        let maxWidth: Float = 200.0
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        let compressionQuality: Float = 0.5
        //50 percent compression
        
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        
        let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = UIImageJPEGRepresentation(img!,CGFloat(compressionQuality))
        UIGraphicsEndImageContext()
        return UIImage(data: imageData!)!
    }
}
