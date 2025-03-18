//
//  loginViewController.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 30/01/25.
//

import UIKit
import AVFoundation


class LoginViewController: UIViewController {

    @IBOutlet weak var creataccount: UIButton!
    @IBOutlet weak var forgot: UIButton!
    @IBOutlet weak var loginbutton: UIButton!
    
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var userNameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginbutton.layer.cornerRadius = 10
        loginbutton.clipsToBounds = true
        
       
        
    }
    
    
   



  

    
    private func login() {
        guard let username = userNameTF.text, !username.isEmpty else {
            //Show alert
            showAlert(title: "Error", message: "Username cannot be empty")

            return
        }
        guard let pass = passwordTF.text, !pass.isEmpty else {
            // alert
            showAlert(title: "Error", message: "Password cannot be empty")
            return
        }
        
        let param = ["username":username,"password":pass]
        self.view.startLoader()
        
        APIHandler.shared.postAPIValues(type: LoginResponseModel.self, apiUrl: APIList.login, method: "POST", formData: param) { result in
            DispatchQueue.main.async {
                self.view.stopLoader()
              
                switch result {
                case .success(let response):
                    print(response)
                    if response.status {
                        Constants.loginDataResponse = response.data.first
                        let uservc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomePageTabBarController") as! HomePageTabBarController
                                self.navigationController?.pushViewController(uservc, animated: true)
                    } else {
                        // show alert
                        self.showAlert(title: "Login Failed", message: response.message)
                        print(response.message)
                    }
                    
                case .failure(let error):
                    self.showAlert(title: "Error", message: "Failed to connect. Please try again.")
                    print(error)
                }
            }

        }
        
    }
    

    

    @IBAction func userhomescreen(_ sender: Any) {
        login()
        
        

    }
    
    @IBAction func forgotscreen(_ sender: Any) {
        let forrvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        self.navigationController?.pushViewController(forrvc, animated: true)
    }
    
    
    @IBAction func registerscreen(_ sender: Any) {
        let regvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SiginViewController") as! SiginViewController
        self.navigationController?.pushViewController(regvc, animated: true)
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
