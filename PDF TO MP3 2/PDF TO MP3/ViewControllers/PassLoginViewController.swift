//
//  PassLoginViewController.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 01/02/25.
//

import UIKit

class PassLoginViewController: UIViewController {

    @IBOutlet weak var forpassLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        forpassLogin.layer.cornerRadius = 10
        forpassLogin.layer.masksToBounds = true

        // Do any additional setup after loading the view.
    }
    

    @IBAction func changeLoginBtn(_ sender: Any) {
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(loginVC, animated: true)
        
        
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
