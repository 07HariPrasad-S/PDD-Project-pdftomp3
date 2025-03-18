//
//  ViewProfileViewController.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 03/02/25.
//

import UIKit

class ViewProfileViewController: UIViewController {

    @IBOutlet weak var LogoutBTn: UIButton!
    @IBOutlet weak var deletAccBtn: UIButton!
    @IBOutlet weak var professionTF: UITextField!
    @IBOutlet weak var emailidTF: UITextField!
    @IBOutlet weak var mobileNoTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var savebtn: UIButton!
    @IBOutlet weak var editprofile: UIButton!
    
    var idData = Constants.loginDataResponse?.id
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savebtn.layer.cornerRadius = 20
        savebtn.layer.masksToBounds = true
        editprofile.layer.cornerRadius = 20
        editprofile.layer.masksToBounds = true
        viewprofile()

        // Do any additional setup after loading the view.
    }
    private func viewprofile() {
        let formData: [String: Any] = ["id":idData ?? ""]
        APIHandler.shared.postAPIValues(type: ViewProfileModel.self, apiUrl: APIList.viewprofile, method: "POST", formData: formData) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if response.status, let profileData = response.data.first {
                        self.usernameTF.text = profileData.username
                        self.nameTF.text = profileData.name
                        self.mobileNoTF.text = profileData.mobilePhone
                        self.emailidTF.text = profileData.email
                        self.professionTF.text = profileData.position
                    } else {
                        print("Error: \(response.message)")
                    }
                case .failure(let error):
                    print("API Error: \(error.localizedDescription)")
                }
            }
        }
        
    }
        
    
    

    @IBAction func editprofileTapped(_ sender: Any) {
        usernameTF.isUserInteractionEnabled = true
        nameTF.isUserInteractionEnabled = true
        mobileNoTF.isUserInteractionEnabled = true
        emailidTF.isUserInteractionEnabled = true
        professionTF.isUserInteractionEnabled = true
        
    }
    
     @IBAction func savebtnTapped(_ sender: Any) {
         guard let username = usernameTF.text, !username.isEmpty,
               let name = nameTF.text, !name.isEmpty,
               let mobileNo = mobileNoTF.text, !mobileNo.isEmpty,
               let email = emailidTF.text, !email.isEmpty,
               let profession = professionTF.text, !profession.isEmpty else {
             print("All fields are required")
             return
             
         }
         let params: [String: Any] = [
             "username": username,
             "name": name,
             "mobile_phone": mobileNo,
             "email": email,
             "POSITION": profession,
             "id": idData ?? "0"
         ]
         
         APIHandler.shared.postAPIValues(type: ViewProfileModel.self, apiUrl: APIList.editprofile, method: "POST", formData: params) { result in
             DispatchQueue.main.async {
                 switch result {
                 case .success(let response):
                     if response.status {
                         self.usernameTF.isUserInteractionEnabled = false
                         self.nameTF.isUserInteractionEnabled = false
                         self.mobileNoTF.isUserInteractionEnabled = false
                         self.emailidTF.isUserInteractionEnabled = false
                         self.professionTF.isUserInteractionEnabled = false
                         print("Profile updated successfully")
                     } else {
                         print(response.message)
                     }
                 case .failure(let error):
                     print(error)
                 }
             }
         }
         
     }
    
     @IBAction func deleteaccountTapped(_ sender: Any) {
         let alertController = UIAlertController(
                 title: "Delete Account",
                 message: "Are you sure you want to delete your account? This action cannot be undone.",
                 preferredStyle: .alert
             )

             let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
                 self.callDeleteAccountAPI()
             }

             let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

             alertController.addAction(deleteAction)
             alertController.addAction(cancelAction)

             self.present(alertController, animated: true, completion: nil)
         }
    private func callDeleteAccountAPI() {
        guard let userId = Constants.loginDataResponse?.id else {
            print("Error: User ID not found")
            return
        }
        let param = ["id":userId]
        
        APIHandler.shared.postAPIValues(type: DeleteProfileModel.self, apiUrl: APIList.deleteaccount, method: "POST", formData: param) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let res):
                    print(res)
                    if res.status {
                        self.handleSignin()
                    } else {
                        // add alert
                    }
                case .failure(let err):
                    print(err)
                }
            }
        }
        
    }
         // 🔹 Function to Call API and Delete Account
//         private func callDeleteAccountAPI() {
//             guard let userId = Constants.loginDataResponse?.id else {
//                 print("Error: User ID not found")
//                 return
//             }
//
//             let url = URL(string: APIList.deleteaccount)!
//             var request = URLRequest(url: url)
//             request.httpMethod = "POST"
//             request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//             let parameters: [String: String] = ["id": "\(userId)"]
//
//             do {
//                 request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
//             } catch {
//                 print("Failed to encode JSON")
//                 return
//             }
//
//             let task = URLSession.shared.dataTask(with: request) { data, response, error in
//                 guard let data = data, error == nil else {
//                     print("Network error: \(error?.localizedDescription ?? "Unknown error")")
//                     return
//                 }
//                 print(String(data: data, encoding: .utf8))
//                 do {
//                     let decodedResponse = try JSONDecoder().decode(DeleteProfileModel.self, from: data)
//                     DispatchQueue.main.async {
//                         if decodedResponse.status {
//                             self.handleLogout()
//                         } else {
//                             print("Error: \(decodedResponse.message)")
//                         }
//                     }
//                 } catch {
//                     print("Decoding error: \(error.localizedDescription)")
//                 }
//             }
//
//             task.resume()
//         }

         // 🔹 Function to Handle Logout and Navigate to Sign-In
         private func handleSignin() {
             // Clear user session
             let storyboard = UIStoryboard(name: "Main", bundle: nil)
             if let loginVC = storyboard.instantiateViewController(withIdentifier: "SiginViewController") as? SiginViewController {
                 self.navigationController?.pushViewController(loginVC, animated: true)
//                 let navController = UINavigationController(rootViewController: loginVC)
//                 if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
//                     sceneDelegate.window?.rootViewController = navController
//                     sceneDelegate.window?.makeKeyAndVisible()
//                 }
             }
     }
    
    @IBAction func logotBtnTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Logout", message: "Are you sure you want to log out?", preferredStyle: .alert)
        
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { _ in
            self.handleLogout()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // 🔹 Function to Handle Logout (Removes TabBarController)
    private func handleLogout() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            let navController = UINavigationController(rootViewController: loginVC)
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = navController
                sceneDelegate.window?.makeKeyAndVisible()
            }
        }
        
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
