//
//  ChangePassViewController.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 01/02/25.
//

import UIKit

class ChangePassViewController: UIViewController {

    @IBOutlet weak var reEnterPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var changePassword: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        changePassword.layer.cornerRadius = 10
        changePassword.clipsToBounds = true

        // Do any additional setup after loading the view.
    }
    private func resetPass() {
        guard let newPassword = newPasswordTF.text, !newPassword.isEmpty else {
            //Show alert
            showAlert(title: "Error", message: "New password cannot be empty")
            
            return
        }
        guard let reEnterPassword = reEnterPasswordTF.text, !reEnterPassword.isEmpty else {
            // alert
            showAlert(title: "Error", message: "Please re-enter your password")
            return
        }
        let param = ["new_password":newPassword,"confirm_password":reEnterPassword]
        APIHandler.shared.postAPIValues(type: ChangePasswordModel.self, apiUrl: APIList.resetpassword, method: "POST", formData: param) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print(response)
                    if response.status {
                        let changePassVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PassLoginViewController") as! PassLoginViewController
                        self.navigationController?.pushViewController(changePassVC , animated: true)
                    } else {
                        // show alert
                        self.showAlert(title: "Reset Failed", message: response.message)
                        print(response.message)
                    }
                    
                case .failure(let error):
                    self.showAlert(title: "Error", message: "Failed to reset password. Please try again.")
                                    
                    print(error)
                }
            }

        }
    }
    
    

    @IBAction func changeBTnPassword(_ sender: Any) {
        resetPass()
        
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
