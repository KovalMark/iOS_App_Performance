import UIKit

class NewsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableNews: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableNews()
        
    }
    
    // MARK: UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    // MARK: Make size for cells
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            
        case 0:
            let cell = tableNews.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath)
            return cell
            
        case 1:
            let cell = tableNews.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath)
            return cell
            
        case 2:
            let cell = tableNews.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath)
            return cell
            
        case 3:
            let cell = tableNews.dequeueReusableCell(withIdentifier: "ControlCell", for: indexPath)
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
