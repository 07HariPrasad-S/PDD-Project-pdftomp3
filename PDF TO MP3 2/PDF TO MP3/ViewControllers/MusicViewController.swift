import UIKit
import AVFoundation

class MusicViewController: UIViewController {
    var audioPlayer: AVPlayer?
    var playerItem: AVPlayerItem?
    var timer: Timer?

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var audioDisplayLabel: UILabel!
    @IBOutlet weak var allBtnView: UIView!
    @IBOutlet weak var forwardBtn: UIButton!
    @IBOutlet weak var backwardBtn: UIButton!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var Btn: UIButton!

    var audioFilesResponse: FetchAudioModel?
    var audioUrl: String?
    var isFromList: Bool = false
    var audioTitle: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        allBtnView.layer.cornerRadius = 20
        allBtnView.layer.masksToBounds = true
        audioDisplayLabel.text = audioTitle ?? "Unknown Audio"

        if !isFromList {
            fetchAudioFiles()
        }
    }

    // MARK: - Fetch Audio Files
    private func fetchAudioFiles() {
        guard let userId = Constants.loginDataResponse?.id else {
            print("Error: No user ID found")
            return
        }
        let param = ["id": userId]
        self.view.startLoader()

        APIHandler.shared.postAPIValues(type: FetchAudioModel.self, apiUrl: APIList.fileslist, method: "POST", formData: param) { result in
            DispatchQueue.main.async {
                self.view.stopLoader()
                switch result {
                case .success(let response):
                    print("API Response: \(response)")
                    if response.status {
                        self.audioFilesResponse = response
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.filterSelectedAudioFiles()
                        }
                    }
                case .failure(let error):
                    print("API Error: \(error.localizedDescription)")
                }
            }
        }
    }

    private func filterSelectedAudioFiles() {
        DispatchQueue.main.async {
            guard let data = self.audioFilesResponse?.data, !data.isEmpty else {
                print("Error: No audio data found")
                return
            }
            
            if let lastAudioFile = data.last,
               let url = lastAudioFile.mp3Files?.last?.mp3File,
               let title = lastAudioFile.mp3Files?.last?.title {
                
                self.audioUrl = "https://q694t46c-8000.inc1.devtunnels.ms/media/\(url)"
                self.audioTitle = title
                self.audioDisplayLabel.text = title
                print("Playing Audio: \(title), URL: \(self.audioUrl ?? "No URL")")

                self.playAudioFromURL(self.audioUrl ?? "")
            } else {
                print("Error: No valid audio file in response")
            }
        }
    }

    // MARK: - Play & Pause Audio
    @IBAction func BtnTapped(_ sender: Any) {
        guard let player = audioPlayer else {
            if let urlString = audioUrl {
                playAudioFromURL(urlString)
            } else {
                print("Error: No audio URL available")
            }
            return
        }
        
        if player.timeControlStatus == .playing {
            player.pause()
            Btn.setImage(UIImage(named: "icons8-play-30"), for: .normal)
        } else {
            player.play()
            Btn.setImage(UIImage(named: "icons8-pause-48 1"), for: .normal)
        }
    }

    func playAudioFromURL(_ urlString: String) {
        guard let url = URL(string: urlString), !urlString.isEmpty else {
            print("Error: Invalid or empty audio URL - \(urlString)")
            return
        }

        playerItem = AVPlayerItem(url: url)
        audioPlayer = AVPlayer(playerItem: playerItem)
        NotificationCenter.default.addObserver(self, selector: #selector(audioDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: playerItem)

        audioPlayer?.play()
        Btn.setImage(UIImage(named: "icons8-pause-48 1"), for: .normal)
    }

    @objc func audioDidFinishPlaying() {
        print("Audio Finished Playing")
        audioPlayer?.seek(to: CMTime.zero)
        Btn.setImage(UIImage(named: "icons8-play-30"), for: .normal)
    }

    // MARK: - Forward & Backward
    @IBAction func backBtnTapped(_ sender: Any) {
        if let player = audioPlayer {
            let currentTime = CMTimeGetSeconds(player.currentTime()) - 10
            let newTime = CMTimeMakeWithSeconds(max(currentTime, 0), preferredTimescale: 1)
            player.seek(to: newTime)
        }
    }

    @IBAction func forwardBtnTapped(_ sender: Any) {
        if let player = audioPlayer, let duration = player.currentItem?.duration.seconds {
            let currentTime = CMTimeGetSeconds(player.currentTime()) + 10
            let newTime = CMTimeMakeWithSeconds(min(currentTime, duration), preferredTimescale: 1)
            player.seek(to: newTime)
        }
    }

    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
