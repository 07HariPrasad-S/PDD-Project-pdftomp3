//
//  DeleteAccountViewController.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 03/02/25.
//

import UIKit

class DeleteAccountViewController: UIViewController {

    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var yesBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        noBtn.layer.cornerRadius = 20
        noBtn.layer.masksToBounds = true
        yesBtn.layer.cornerRadius = 20
        yesBtn.layer.masksToBounds = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func yesBtnTapped(_ sender: Any) {
        print("yes btn tapped")
        let regvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SiginViewController") as! SiginViewController
        self.navigationController?.pushViewController(regvc, animated: true)
        
    }
    
    @IBAction func noBtnTapped(_ sender: Any) {
        print("no btn tapped")
        let viewvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewProfileViewController") as! ViewProfileViewController
        self.navigationController?.pushViewController(viewvc, animated: true)
        
        
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
