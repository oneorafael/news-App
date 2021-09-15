//
//  ViewController.swift
//  news App
//
//  Created by Rafael Oliveira on 31/08/21.
//

import UIKit

class NewsListTableViewController: UITableViewController {
    //MARK: - Properties & IBOutlet
    var articlesVM: ArticleListViewModel!
    @IBOutlet weak var backgroundActivityIndicator: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: K.reusableIdentifier)
        setup()
        
    //init activityIndicator status
        backgroundActivityIndicator.isHidden = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    //prepare data to display on tableView
    func setup(){
        let urlPath = URL(string: K.urlPath)!
        if WebService.isConnectedToInternet {
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
        } else {
            self.backgroundActivityIndicator.isHidden = true
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
            noInternetAvaliableAlert()
            
        }
        
    }
    
    //MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return articlesVM == nil ? 0 : articlesVM.numberOfSections
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articlesVM.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reusableIdentifier, for: indexPath) as! NewsTableViewCell
        cell.parentVC = self
        let article = self.articlesVM.articles[indexPath.row]
        cell.prepare(Article: article)
        cell.bookmarkBtn.tag = indexPath.row
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.contentViewSegue, sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.contentViewSegue{
            let destination = segue.destination as! ContentDetailViewController
            destination.article = articlesVM.articles[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
}

//MARK: - noInternetAvaliableAlert extension
extension NewsListTableViewController {
    //Notificação de falta de conexão com internet
    func noInternetAvaliableAlert(){
        let alert = UIAlertController(title: "Sem conexão disponivel", message: "Verifique a sua conexão com a internet e tente novamente", preferredStyle: .alert)
        let cancelOption = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let reloadData = UIAlertAction(title: "Tentar novamente", style: .destructive) { UIAlertAction in
            self.setup()
        }
        alert.addAction(cancelOption)
        alert.addAction(reloadData)
        self.present(alert, animated: true, completion: nil)
    }
}
