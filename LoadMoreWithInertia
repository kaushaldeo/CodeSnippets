

import UIKit

public typealias FetchingBlock = ((_ urls: [String]) -> Void)

class DemoViewController: UITableViewController {
    
    var messages = [String]()
    
    fileprivate func urls(handler: FetchingBlock? = nil) {
        let background = DispatchQueue.global(qos: .background)
        background.async {
            guard let path = Bundle.main.url(forResource: "data", withExtension: "json") else  { return }
            guard let data = try? Data(contentsOf: path) else { return }
            guard let urls = try? JSONDecoder().decode([String].self, from: data) else { return }
            let upper = max(0, urls.count - 1)
            let lower = max(0, upper - self.size*(self.currentPage + 1))
            let array = Array(urls[lower...upper])
            DispatchQueue.main.async {
                handler?(array)
            }
        }
    }
    
    var currentPage = 0
    let size = 10
    var isLoadMore = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.urls { (urls) in
            self.messages = urls
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let url = URL(string:self.messages[indexPath.row])
        cell.textLabel?.text = url?.lastPathComponent
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row < 2, self.isLoadMore {
            self.isLoadMore = false
            self.currentPage += 1
            self.urls(handler: { (urls) in
                self.messages = urls
                self.tableView.reloadDataSource()
                self.isLoadMore = true
            })
        }
    }
}



extension UITableView {
    func reloadDataSource() {
        let beforeTableViewContentHeight = self.contentSize.height
        let beforeTableViewOffset = self.contentOffset.y
        self.reloadData()
        self.layer.layoutIfNeeded()
        let offSet = CGPoint(x: 0, y: beforeTableViewOffset + (self.contentSize.height - beforeTableViewContentHeight))
        self.contentOffset = offSet
    }
}
