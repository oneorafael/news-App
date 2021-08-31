//
//  ViewController.swift
//  news App
//
//  Created by Rafael Oliveira on 31/08/21.
//

import UIKit

class NewsListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let urlPath = URL(string: K.urlPath)!
        WebService().getData(url: urlPath) { _ in
            
        }
    }


}

