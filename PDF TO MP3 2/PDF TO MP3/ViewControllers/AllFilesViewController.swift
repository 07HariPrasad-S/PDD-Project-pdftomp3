import UIKit

class AllFilesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var FileSerachBar: UISearchBar!
    @IBOutlet weak var fileListTableView: UITableView!
    @IBOutlet weak var headingLabel: UILabel!
    
    var audioFilesResponse: FetchAudioModel?
    var filteredFiles: [File] = []
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fileListTableView.delegate = self
        fileListTableView.dataSource = self
        FileSerachBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
                    print(response)
                    if response.status {
                        self.audioFilesResponse = response
                        self.filteredFiles = response.data.first?.pdfFiles ?? []
                        self.fileListTableView.reloadData()
                    }
                case .failure(let err):
                    print(err)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredFiles.count : (audioFilesResponse?.data.first?.pdfFiles?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FileTableViewCell", for: indexPath) as! FileTableViewCell
        let pdfFiles = isSearching ? filteredFiles : (audioFilesResponse?.data.first?.pdfFiles ?? [])
        cell.fileNameLabel.text = pdfFiles[indexPath.row].title
        cell.dateLabel.text = Utils.convertISOToDateString(isoDate: pdfFiles[indexPath.row].date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pdfFiles = isSearching ? filteredFiles : (audioFilesResponse?.data.first?.pdfFiles ?? [])
        if let pdf = pdfFiles[indexPath.row].pdfFile {
            let pdfReaderVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PDFViewController") as! PDFViewController
            pdfReaderVC.pdfURL = "https://q694t46c-8000.inc1.devtunnels.ms/media/\(pdf)"
            self.navigationController?.pushViewController(pdfReaderVC, animated: true)
        }
    }
    
    // MARK: - Search Bar Functionality
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredFiles = audioFilesResponse?.data.first?.pdfFiles ?? []
        } else {
            isSearching = true
            filteredFiles = audioFilesResponse?.data.first?.pdfFiles?.filter { $0.title.lowercased().contains(searchText.lowercased()) } ?? []
        }
        fileListTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        isSearching = false
        filteredFiles = audioFilesResponse?.data.first?.pdfFiles ?? []
        fileListTableView.reloadData()
        searchBar.resignFirstResponder()
    }
}
