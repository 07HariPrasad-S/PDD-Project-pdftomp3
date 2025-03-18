//
//  ForgotPasswordViewController.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 31/01/25.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var mailVerifyTF: UITextField!
    @IBOutlet weak var SendButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        SendButton.layer.cornerRadius = 10
        SendButton.clipsToBounds = true

        // Do any additional setup after loading the view.
    }
    private func emailverify() {
        guard let emailverify = mailVerifyTF.text, !emailverify.isEmpty else {
            //Show alert
            showAlert(title: "Error", message: "Email cannot be empty")
            
            return
        }
        let param = ["email":emailverify]
        APIHandler.shared.postAPIValues(type: ForgotPasswordModel.self, apiUrl: APIList.forgotpassword, method: "POST", formData: param) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print(response)
                    if response.status {
                        let otpForgotVC = self.storyboard?.instantiateViewController(withIdentifier: "OtpForgotPasswordViewController") as! OtpForgotPasswordViewController
                        self.navigationController?.pushViewController(otpForgotVC, animated: true)
                    } else {
                        // show alert
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
    
    @IBAction func otpForgot(_ sender: Any) {
        emailverify()
        
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
