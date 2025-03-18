//
//  HomeViewController.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 31/01/25.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var filesView: UIView!
    @IBOutlet weak var pdfToMp3View: UIView!
    @IBOutlet weak var audioFilesView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        filesView.layer.cornerRadius = 10
        pdfToMp3View.layer.cornerRadius = 10
        audioFilesView.layer.cornerRadius = 10
        
        filesView.layer.masksToBounds = true
        pdfToMp3View.layer.masksToBounds = true
        audioFilesView.layer.masksToBounds = true
        self.tabBarController?.navigationItem.setHidesBackButton(true, animated: true)
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func audioButtonTapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AudioFilesViewController") as! AudioFilesViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func fileBtnTapped(_ sender: Any) {
        let filevc = self.storyboard?.instantiateViewController(withIdentifier: "AllFilesViewController") as! AllFilesViewController
        self.navigationController?.pushViewController(filevc, animated: true)
    }
    
    @IBAction func pdfToaudioBtn(_ sender: Any) {
        let pdfvc = self.storyboard?.instantiateViewController(withIdentifier: "UploadViewController") as!
        UploadViewController
        self.navigationController?.pushViewController(pdfvc, animated: true)
    }
}
