import UIKit

protocol FavoritesDelegate: AnyObject {
    func favTapped(selectedIndex: Int, likeButton: UIButton)
}

class AudioFilesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, FavoritesDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var audioListTableView: UITableView!
    @IBOutlet weak var headingLabel: UILabel!
    
    var filesName = ["hari", "hhd", "hdgh", "hdfhd", "dfhdfh"]
    var audioFilesResponse: FetchAudioModel?
    var filteredAudioFiles: [File] = []
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioListTableView.delegate = self
        audioListTableView.dataSource = self
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAudioFiles()
    }
    
    private func fetchAudioFiles() {
        guard let userId = Constants.loginDataResponse?.id else { return }
        let param = ["id": userId]
        self.view.startLoader()
        APIHandler.shared.postAPIValues(type: FetchAudioModel.self, apiUrl: APIList.fileslist, method: "POST", formData: param) { result in
            DispatchQueue.main.async {
                self.view.stopLoader()
                switch result {
                case .success(let response):
                    if response.status {
                        self.audioFilesResponse = response
                        self.filteredAudioFiles = response.data[1].mp3Files ?? []
                        self.audioListTableView.reloadData()
                    }
                case .failure(let err):
                    print(err)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredAudioFiles.count : (audioFilesResponse?.data[1].mp3Files?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = audioListTableView.dequeueReusableCell(withIdentifier: "AudioFilesTableViewCell", for: indexPath) as! AudioFilesTableViewCell
        let audioFiles = isSearching ? filteredAudioFiles : (audioFilesResponse?.data[1].mp3Files ?? [])
        
        cell.fileNameLabel.text = audioFiles[indexPath.row].title
        cell.currentIndex = audioFiles[indexPath.row].id
        cell.delegate = self
        cell.dateLabel.text = Utils.convertISOToDateString(isoDate: audioFiles[indexPath.row].date)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let audioFiles = isSearching ? filteredAudioFiles : (audioFilesResponse?.data[1].mp3Files ?? [])
        
        if let audio = audioFiles[indexPath.row].mp3File {
            let selectedAudio = audioFiles[indexPath.row]
            let musicVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MusicViewController") as! MusicViewController
            musicVC.isFromList = true
            musicVC.audioUrl = "https://q694t46c-8000.inc1.devtunnels.ms/media/\(audio)"
            musicVC.audioTitle = selectedAudio.title
            self.navigationController?.pushViewController(musicVC, animated: true)
        }
    }
    
    func favTapped(selectedIndex: Int, likeButton: UIButton) {
        print("====== MP3 id", selectedIndex)

        guard let userId = Constants.loginDataResponse?.id else { return }

        let param = ["id": userId, "mp3_id": selectedIndex]

        // Use button's tag to track the state instead of checking the image
        let isCurrentlyLiked = likeButton.tag == 1
        likeButton.tag = isCurrentlyLiked ? 0 : 1
        
        let newImage = isCurrentlyLiked ? UIImage(named: "heartunfill") : UIImage(named: "fillheart")
        likeButton.setImage(newImage, for: .normal)

        self.view.startLoader()

        APIHandler.shared.postAPIValues(type: AddFavouriteModel.self, apiUrl: APIList.addfavorite, method: "POST", formData: param) { result in
            DispatchQueue.main.async {
                self.view.stopLoader()
                switch result {
                case .success(let data):
                    if data.status {
                        print("Fav Added...")
                    } else {
                        print("Failed to add favorite")
                        // Revert UI if API fails
                        likeButton.tag = isCurrentlyLiked ? 1 : 0
                        likeButton.setImage(isCurrentlyLiked ? UIImage(named: "fillheart") : UIImage(named: "heartunfill"), for: .normal)
                    }
                case .failure(let err):
                    print("Error:", err.localizedDescription)
                    // Revert UI on API failure
                    likeButton.tag = isCurrentlyLiked ? 1 : 0
                    likeButton.setImage(isCurrentlyLiked ? UIImage(named: "fillheart") : UIImage(named: "heartunfill"), for: .normal)
                }
            }
        }
    }


    
    // MARK: - Search Bar Delegate Methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredAudioFiles = audioFilesResponse?.data[1].mp3Files ?? []
        } else {
            isSearching = true
            filteredAudioFiles = audioFilesResponse?.data[1].mp3Files?.filter { $0.title.lowercased().contains(searchText.lowercased()) } ?? []
        }
        audioListTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        isSearching = false
        filteredAudioFiles = audioFilesResponse?.data[1].mp3Files ?? []
        audioListTableView.reloadData()
    }
}
