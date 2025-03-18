//
//  OnBoardingViewController.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 29/01/25.
//

import UIKit

class OnBoardingViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 20
        loginButton.layer.masksToBounds = true
        signUpButton.layer.cornerRadius = 20
        signUpButton.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    


    @IBAction func loginTapped(_ sender: Any) {
        print("login tapped")
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        print("SignUp tapped")
        let signinVC = self.storyboard?.instantiateViewController(withIdentifier: "SiginViewController") as! SiginViewController
        self.navigationController?.pushViewController(signinVC, animated: true)
    }
    
}
