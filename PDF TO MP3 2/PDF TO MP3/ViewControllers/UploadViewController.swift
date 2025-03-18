//
//  UploadViewController.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 01/02/25.
//

import UIKit
import UniformTypeIdentifiers

class UploadViewController: UIViewController, UIDocumentPickerDelegate {
    
    @IBOutlet weak var uploadView: UIView!
    @IBOutlet weak var browseBTn: UIButton!
    var selectedPDFUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        browseBTn.layer.cornerRadius = 10
        browseBTn.clipsToBounds = true
        uploadView.layer.cornerRadius = 20
        uploadView.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func browBtnTapped(_ sender: Any) {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.pdf])
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let selectedUrl = urls.first {
            selectedPDFUrl = selectedUrl
            self.uploadPDF(selectedPdf: selectedUrl)
            print("Selected PDF: \(selectedUrl)")
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("Document picker was cancelled")
    }
    
    private func uploadPDF(selectedPdf: URL) {
        guard let userId = Constants.loginDataResponse?.id else {return}
        let param = ["id":userId,"pdf_file":selectedPdf] as [String : Any]
        self.view.startLoader()
        APIHandler.shared.postAPIValuesWithPDF(type: UploadedPDFModel.self, apiUrl: APIList.uploadpdf, formData: param) { result in
            DispatchQueue.main.async {
               
                switch result {
                case .success(let res):
                    if res.status {
                        Constants.lastUploadedPDF = res
                        self.view.stopLoader()
                                let forrvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VoiceViewController") as! VoiceViewController
                                self.navigationController?.pushViewController(forrvc, animated: true)
                    }else{
                        self.view.stopLoader()
                    }
                   
                    
                    print(res)
                case .failure(let err):
                    print(err)
                    self.view.stopLoader()
                }
            }
            
        }
    }
}
