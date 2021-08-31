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
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup(){
        let urlPath = URL(string: K.urlPath)!
        WebService().getData(url: urlPath) { articles in
            if !articles.isEmpty {
                self.articlesVM = ArticleListViewModel(articles: articles)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reusableIdentifier, for: indexPath)
        let article = self.articlesVM.articles[indexPath.row]
        cell.textLabel?.text = article.title
        cell.detailTextLabel?.text = article.description
        return cell
    }
}

