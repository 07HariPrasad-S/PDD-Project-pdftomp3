//
//  PDFViewController.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 19/02/25.
//

import UIKit
import WebKit

class PDFViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    var pdfURL: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPDF()
        // Do any additional setup after loading the view.
    }
    private func loadPDF() {
        guard let url = URL(string: pdfURL) else { return }
        let request = URLRequest(url: url)
        webview.load(request)
    }
}
