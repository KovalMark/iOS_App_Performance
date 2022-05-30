import UIKit

class NewsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableNews: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableNews()
    }
    
    // MARK: UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let titleCell = tableNews.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath)
        let textCell = tableNews.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath)
        let photoCell = tableNews.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath)
        let controlCell = tableNews.dequeueReusableCell(withIdentifier: "ControlCell", for: indexPath)
        
        return titleCell; textCell; photoCell; controlCell
    }
    
    func registerTableNews() {
        tableNews.register(UINib(nibName: "TitleCell", bundle: nil), forCellReuseIdentifier: "TitleCell")
        tableNews.register(UINib(nibName: "TextCell", bundle: nil), forCellReuseIdentifier: "TextCell")
        tableNews.register(UINib(nibName: "PhotoCell", bundle: nil), forCellReuseIdentifier: "PhotoCell")
        tableNews.register(UINib(nibName: "ControlCell", bundle: nil), forCellReuseIdentifier: "ControlCell")
    }
}
