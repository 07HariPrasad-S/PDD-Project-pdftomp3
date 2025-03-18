//
//  ProfileViewController.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 03/02/25.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var profilePicImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var ViewProfileBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewProfileBtn.layer.cornerRadius = 10
        ViewProfileBtn.clipsToBounds = true
        userLabel.text = Constants.loginDataResponse?.username
        
        profilePicImage.layer.borderWidth = 1
        profilePicImage.layer.borderColor = UIColor.black.cgColor
        profilePicImage.clipsToBounds = true
        profilePicImage.contentMode = .scaleAspectFill
        setupTapGesture()
        
        }
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
            // Ensure the image view has a proper frame before applying corner radius
            profilePicImage.layer.cornerRadius = profilePicImage.frame.height / 2
        }

    func setupTapGesture() {
            let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            profilePicImage.isUserInteractionEnabled = true
            profilePicImage.addGestureRecognizer(tap)
        }
    
    @objc func imageTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
   
    
    @IBAction func viewTapped(_ sender: Any) {
        print("view tapped")
        let viewVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewProfileViewController") as! ViewProfileViewController
        self.navigationController?.pushViewController(viewVC, animated: true)
    }
    
}
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            DispatchQueue.main.async {
                self.profilePicImage.image = selectedImage
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
