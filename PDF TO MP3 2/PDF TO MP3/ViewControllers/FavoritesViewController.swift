import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var favSerachBar: UISearchBar!
    @IBOutlet weak var FavoritesListTableView: UITableView!
    @IBOutlet weak var headingLabel: UILabel!
    
    var favResponse: FetchFavouriteModel?
    var filteredFavData: [FavouritesData] = []
    var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        FavoritesListTableView.delegate = self
        FavoritesListTableView.dataSource = self
        favSerachBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFav()
    }
    
    private func fetchFav() {
        guard let userId = Constants.loginDataResponse?.id else { return }
        let param = ["id": userId]
        self.view.startLoader()
        APIHandler.shared.postAPIValues(type: FetchFavouriteModel.self, apiUrl: APIList.favorite, method: "POST", formData: param) { result in
            DispatchQueue.main.async {
                self.view.stopLoader()
                switch result {
                case .success(let response):
                    print(response)
                    if response.status {
                        self.favResponse = response
                        self.filteredFavData = response.data
                        self.FavoritesListTableView.reloadData()
                    }
                case .failure(let err):
                    print(err)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredFavData.count : favResponse?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FavoritesListTableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        let favData = isSearching ? filteredFavData[indexPath.row] : favResponse?.data[indexPath.row]
        if let favData = favData {
            cell.fileNameLabel.text = favData.title
            cell.dateLabel.text = Utils.formatDateString(dateString: favData.dateAdded)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favData = isSearching ? filteredFavData[indexPath.row] : favResponse?.data[indexPath.row]
        if let favData = favData {
            let musicVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MusicViewController") as! MusicViewController
            musicVC.isFromList = true
            musicVC.audioUrl = "https://q694t46c-8000.inc1.devtunnels.ms\(favData.fileURL)"
            musicVC.audioTitle = favData.title
            self.navigationController?.pushViewController(musicVC, animated: true)
        }
    }
    
    // MARK: - Search Bar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredFavData = favResponse?.data ?? []
        } else {
            isSearching = true
            filteredFavData = favResponse?.data.filter { $0.title.lowercased().contains(searchText.lowercased()) } ?? []
        }
        FavoritesListTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        filteredFavData = favResponse?.data ?? []
        FavoritesListTableView.reloadData()
    }
}
