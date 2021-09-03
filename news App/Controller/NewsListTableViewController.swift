//
//  ViewController.swift
//  news App
//
//  Created by Rafael Oliveira on 31/08/21.
//

import UIKit

class NewsListTableViewController: UITableViewController {
    //MARK: - Properties
    var articlesVM: ArticleListViewModel!
    @IBOutlet weak var backgroundActivityIndicator: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: K.reusableIdentifier)
        setup()
        backgroundActivityIndicator.isHidden = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
    }
    
    func setup(){
        let urlPath = URL(string: K.urlPath)!
        WebService().getData(url: urlPath) { articles in
            if !articles.isEmpty {
                self.articlesVM = ArticleListViewModel(articles: articles)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.backgroundActivityIndicator.isHidden = true
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return articlesVM == nil ? 0 : articlesVM.numberOfSections
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articlesVM.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reusableIdentifier, for: indexPath) as! NewsTableViewCell
        let article = self.articlesVM.articles[indexPath.row]
        cell.prepare(Article: article)
        cell.bookmarkBtn.tag = indexPath.row
        return cell
    }
}

