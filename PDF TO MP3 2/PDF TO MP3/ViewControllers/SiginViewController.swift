//
//  SiginViewController.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 30/01/25.
//

import UIKit

class SiginViewController: UIViewController {

    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var firstnameTestfield: UITextField!
    @IBOutlet weak var loginbutton: UIButton!
    @IBOutlet weak var nextbutton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        nextbutton.layer.cornerRadius = 10
        nextbutton.clipsToBounds = true

        // Do any additional setup after loading the view.
    }
    private func signUp() {
        guard let firstName = firstnameTestfield.text, !firstName.isEmpty else {
            //showAlert(message: "First name cannot be empty")
            showAlert(title: "Error", message: "First name cannot be empty")
            return
        }
        
        guard let lastName = lastnameTextField.text, !lastName.isEmpty else {
            //showAlert(message: "Last name cannot be empty")
            showAlert(title: "Error", message: "Last name cannot be empty")
            return
        }
        
        guard let username = usernameTextField.text, !username.isEmpty else {
            //showAlert(message: "Username cannot be empty")
            showAlert(title: "Error", message: "Username cannot be empty")
            return
        }
        
        guard let email = emailTextField.text, !email.isEmpty else {
            //showAlert(message: "Email cannot be empty")
            showAlert(title: "Error", message: "Email cannot be empty")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            //showAlert(message: "Password cannot be empty")
            showAlert(title: "Error", message: "Password cannot be empty")
            return
        }
        
        
        let param = ["first_name":firstName,"last_name":lastName,"username":username,"email":email,"password":password]
        
        APIHandler.shared.postAPIValues(type: RegisterResponseModel.self, apiUrl: APIList.signup, method: "POST",formData:param){
            result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print(response)
                    if response.status {
                        let otpvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OtpRegisterViewController") as! OtpRegisterViewController
                        self.navigationController?.pushViewController(otpvc, animated: true)
                    } else {
                        self.showAlert(title: "Sign Up Failed", message: response.message)
                        print(response.message)
                    }
                    
                case .failure(let error):
                    self.showAlert(title: "Error", message: "Failed to connect. Please try again.")
                    print(error)
                }
            }
            
        }
    }


    
    

    @IBAction func nextotpreg(_ sender: Any) {
        signUp()
        
    }
    
    @IBAction func loginscreen(_ sender: Any) {
        let logvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(logvc, animated: true)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


