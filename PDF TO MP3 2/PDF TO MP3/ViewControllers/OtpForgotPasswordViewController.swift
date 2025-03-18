//
//  OtpForgotPasswordViewController.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 31/01/25.
//

import UIKit

class OtpForgotPasswordViewController: UIViewController {

    @IBOutlet weak var otpVerifyTextfield: UITextField!
    @IBOutlet weak var submitOtp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        submitOtp.layer.cornerRadius = 10
        submitOtp.clipsToBounds = true


        // Do any additional setup after loading the view.
    }
    private func forgotverifyotp() {
        guard let verifyOtp = otpVerifyTextfield.text, !verifyOtp.isEmpty else {
            //Show alert
            showAlert(title: "Error", message: "OTP cannot be empty")
            
            return
        }
        let param = ["otp":verifyOtp]
        APIHandler.shared.postAPIValues(type: OtpForgotPasswordModel.self, apiUrl: APIList.forgotverify, method: "POST", formData: param) {
            result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print(response)
                    if response.status {
                        print("submit tapped")
                        let changeVC = self.storyboard?.instantiateViewController(withIdentifier: "SuccessfullPassViewController") as! SuccessfullPassViewController
                        self.navigationController?.pushViewController(changeVC, animated: true)

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
        
    

    @IBAction func submitbtnTapped(_ sender: Any) {
        forgotverifyotp()
        
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
