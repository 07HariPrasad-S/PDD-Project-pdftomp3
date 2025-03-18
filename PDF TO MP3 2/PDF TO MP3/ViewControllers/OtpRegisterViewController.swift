//
//  OtpRegisterViewController.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 31/01/25.
//

import UIKit

class OtpRegisterViewController: UIViewController {
    
    @IBOutlet weak var otpRegisterTF: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.cornerRadius = 10
        submitButton.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }
    private func otpRegister() {
        guard let enterOtp = otpRegisterTF.text, !enterOtp.isEmpty else {
            //Show alert
            showAlert(title: "Error", message: "OTP cannot be empty")
            
            return
        }
        
        
        let param = ["otp":enterOtp]
        
        APIHandler.shared.postAPIValues(type: OtpRegisterModel.self, apiUrl: APIList.otpRegister, method: "POST", formData: param) {
            result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print(response)
                    if response.status {
                        let otpvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                        self.navigationController?.pushViewController(otpvc, animated: true)
                    } else {
                        self.showAlert(title: "Verification Failed", message: response.message)
                        print(response.message)
                    }
                    
                case .failure(let error):
                    self.showAlert(title: "Error", message: "Failed to connect. Please try again.")
                    print(error)
                
                }
            }
        }

        
    }

    
    
    
    
    
    @IBAction func otpverfication(_ sender: Any) {
        otpRegister()
        
    }
}

    
   

