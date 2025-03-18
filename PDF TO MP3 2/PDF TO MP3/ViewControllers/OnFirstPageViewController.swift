//
//  OnFirstPageViewController.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 29/01/25.
//
import AVKit
import AVFoundation
import UIKit

class OnFirstPageViewController: UIViewController {

    @IBOutlet weak var getStartedButton: UIButton! // Corrected IBOutlet
    
    var playerViewController: AVPlayerViewController?
    
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getStartedButton.layer.cornerRadius = 10
        getStartedButton.clipsToBounds = true
        
        
       // setupAVPlayer()
        
    }
    
    func setupAVPlayer() {
        if let url = URL(string: "https://file-examples.com/storage/fe7502810367c61059aaa19/2017/11/file_example_MP3_700KB.mp3") { // Use MP4 instead of MP3
            let player = AVPlayer(url: url)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            playerViewController.showsPlaybackControls = true
            
            playerViewController.view.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 400)
            addChild(playerViewController)
            view.addSubview(playerViewController.view)
            playerViewController.didMove(toParent: self)

            player.play()
        } else {
            print("Invalid URL")
        }
    }

        
    @IBAction func getStartedTapped(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OnBoardingViewController") as! OnBoardingViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
}






