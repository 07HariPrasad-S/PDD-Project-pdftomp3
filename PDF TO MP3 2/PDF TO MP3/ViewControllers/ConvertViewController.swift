//
//  ConvertViewController.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 03/02/25.
//

import UIKit

class ConvertViewController: UIViewController {

    @IBOutlet weak var convertBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        convertBtn.layer.cornerRadius = 10
        convertBtn.clipsToBounds = true

        // Do any additional setup after loading the view.
    }
    

    @IBAction func convertBtnTapped(_ sender: Any) {
        let malevoicevc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MusicViewController") as! MusicViewController
        self.navigationController?.pushViewController(malevoicevc, animated: true)
    }
    

}
