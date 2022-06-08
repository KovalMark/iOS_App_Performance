import UIKit

// MARK: NewsController
class NewsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let newsVKService = NewsVKService()
    var news: [NewsVK] = []
    var titleNews: [TitleVKNews] = []
    var bodyNews: [AttachBodyVKNews] = []
    var sizePhoto: [SizesPhotoVKNews] = []
    @IBOutlet weak var tableNews: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableNews()
    }
    
    // MARK: UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            
        case 0:
            guard let cell = tableNews.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as? TitleCell else {
                preconditionFailure("Failed to create a cell")
            }
            
            let titleCell = titleNews[indexPath.section]
            cell.heading?.text = titleCell.name
            cell.secondHeading?.text = titleCell.screenName
            cell.imageHeading?.loadImage(with: titleCell.avatarPost)
            
            return cell
            
        case 1:
            guard let cell = tableNews.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath) as? TextCell else {
                preconditionFailure("Failed to create a cell")
            }
            
            let textCell = bodyNews[indexPath.section]
            cell.textView?.text = textCell.text
            
            return cell
            
        case 2:
            guard let cell = tableNews.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else {
                preconditionFailure("Failed to create a cell")
            }
            
            let photoCell = sizePhoto[indexPath.section]
            cell.photoPost?.loadImage(with: photoCell.url)
            return cell
            
        case 3:
            guard let cell = tableNews.dequeueReusableCell(withIdentifier: "ControlCell", for: indexPath) as? ControlCell else {
                preconditionFailure("Failed to create a cell")
            }
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    // MARK: registerTableNews
    func registerTableNews() {
        tableNews.register(UINib(nibName: "TitleCell", bundle: nil), forCellReuseIdentifier: "TitleCell")
        tableNews.register(UINib(nibName: "TextCell", bundle: nil), forCellReuseIdentifier: "TextCell")
        tableNews.register(UINib(nibName: "PhotoCell", bundle: nil), forCellReuseIdentifier: "PhotoCell")
        tableNews.register(UINib(nibName: "ControlCell", bundle: nil), forCellReuseIdentifier: "ControlCell")
    }
}

// MARK: Make size for cells
extension NewsController {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            
        case 0:
            return 50
            
        case 1:
            return 250
            
        case 2:
            return 200
            
        case 3:
            return 50
            
        default:
            return 550
        }
    }
}
