//
//  readLaterTableViewController.swift
//  news App
//
//  Created by Rafael Oliveira on 03/09/21.
//

import UIKit

class ReadLaterTableViewController: UITableViewController {
    //MARK: - Properties
    var readLaterListVM = ReadLaterListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataFromCoreData()
    }
    // MARK: - Functions
    
    //get data from coredata and display on tableView
    func loadDataFromCoreData(){
        readLaterListVM.loadNews { results in
            for result in results {
                DispatchQueue.main.async {
                    self.readLaterListVM.news.append(result)
                }
            }
        }
        self.tableView.reloadData()
    }
    
    //remove data
    @IBAction func removeAllNews(_ sender: UIBarButtonItem) {
        readLaterListVM.removeAll()
        loadDataFromCoreData()
        displayNotificationAndDismissIn1Second(notificationTitle: "Noticias apagadas", notificationMessage: "Todas as noticias foram apagadas com sucesso.")
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return readLaterListVM.numberOfRowsInSection(section: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.readLaterReausableCell, for: indexPath)
        let news = readLaterListVM.news[indexPath.row]
        cell.textLabel?.text = news.newsTitle
        cell.detailTextLabel?.text = news.newsDescription

        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            readLaterListVM.removeNews(at: indexPath.row)
            loadDataFromCoreData()
            displayNotificationAndDismissIn1Second(notificationTitle: "Noticia apagada", notificationMessage: "Essa noticia foi apagada com sucesso")
        }
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.readLaterContentViewSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ContentDetailViewController
        destination.news = readLaterListVM.news[(tableView.indexPathForSelectedRow?.row)!]
    }
}

