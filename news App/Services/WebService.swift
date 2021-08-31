//
//  WebService.swift
//  news App
//
//  Created by Rafael Oliveira on 31/08/21.
//

import Foundation
class WebService {
    func getData(url:URL, completionHandler:@escaping([Article])->()){
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let data = data else {return}
                let articleArray = try? JSONDecoder().decode(ArticleList.self, from: data)
                if let articleArray = articleArray {
                    completionHandler(articleArray.articles)
                }
            }
        }.resume()
    }
}
