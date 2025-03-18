//
//  LogOutViewController.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 03/02/25.
//

import UIKit

class LogOutViewController: UIViewController {

    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        yesBtn.layer.cornerRadius = 20
        yesBtn.layer.masksToBounds = true
        noBtn.layer.cornerRadius = 20
        noBtn.layer.masksToBounds = true

        // Do any additional setup after loading the view.
    }
    

    @IBAction func yestBtnTapped(_ sender: Any) {
        let forrvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(forrvc, animated: true)
    }
    
     @IBAction func noBtnTapped(_ sender: Any) {
         let forrvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewProfileViewController") as! ViewProfileViewController
         self.navigationController?.pushViewController(forrvc, animated: true)

         
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
