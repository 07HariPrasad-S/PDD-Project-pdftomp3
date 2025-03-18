//
//  VoiceViewController.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 01/02/25.
//

import UIKit

class VoiceViewController: UIViewController {
    
    
    @IBOutlet weak var femaleview: UIView!
    @IBOutlet weak var maleview: UIView!
    @IBOutlet weak var ConvertBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var maleBTn: UIButton!
    var selectedVoice = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        maleBTn.layer.cornerRadius = 10
        maleBTn.clipsToBounds = true
        femaleBtn.layer.cornerRadius = 10
        femaleBtn.clipsToBounds = true
        ConvertBtn.layer.cornerRadius = 10
        ConvertBtn.clipsToBounds = true
        femaleview.layer.cornerRadius = 20
        femaleview.clipsToBounds = true
        maleview.layer.cornerRadius = 20
        maleview.clipsToBounds = true
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func convertTapped(_ sender: Any) {
        guard let pdfId = Constants.lastUploadedPDF?.data.first?.id, let userId = Constants.loginDataResponse?.id else {return}
        let param = ["voiceType":selectedVoice,"pdf_id":pdfId,"id":userId] as [String : Any]
        self.view.startLoader()
        APIHandler.shared.postAPIValues(type: VoiceSelectionModel.self, apiUrl: APIList.choosevoice, method: "POST", formData: param) { result in
            DispatchQueue.main.async {
               
                switch result {
                case .success(let response):
                    print(response)
                    if response.status {
                        self.view.stopLoader()
                        let malevoicevc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MusicViewController") as! MusicViewController
                        self.navigationController?.pushViewController(malevoicevc, animated: true)
                    } else {
                        self.view.stopLoader()
                    }
                case .failure(let err):
                    print(err)
                    self.view.stopLoader()
                }
            }
        }
    }
    
    @IBAction func maleBtnTapped(_ sender: Any) {
        selectedVoice = "Male"
        maleBTn.backgroundColor = UIColor.black  // Selected color
        femaleBtn.backgroundColor = UIColor.lightGray // Reset color
    }
    
    @IBAction func femaleBtnTapped(_ sender: Any) {
        selectedVoice = "Female"
        femaleBtn.backgroundColor = UIColor.black  // Selected color
        maleBTn.backgroundColor = UIColor.lightGray // Reset color
    }
}
