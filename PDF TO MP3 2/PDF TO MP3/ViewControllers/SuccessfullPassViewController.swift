//
//  SuccessfullPassViewController.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 01/02/25.
//

import UIKit

class SuccessfullPassViewController: UIViewController {

    @IBOutlet weak var changePassword: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        changePassword.layer.cornerRadius = 10
        changePassword.clipsToBounds = true


        // Do any additional setup after loading the view.
    }
    
    @IBAction func ChangePasswordButton(_ sender: Any) {
        print("change pass tapped")
        let changeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangePassViewController") as! ChangePassViewController
        self.navigationController?.pushViewController(changeVC, animated: true)
        
        
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
