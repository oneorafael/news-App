//
//  ArticleViewModel.swift
//  news App
//
//  Created by Rafael Oliveira on 31/08/21.
//

import Foundation

struct ArticleListViewModel {
    let articles: [Article]
    
    var numberOfSections:Int {return 1}
    func numberOfRowsInSection(_ section:Int) -> Int {
        return articles.count
    }
    
    func articleAt( index: Int) -> ArticleViewModel {
        let article = articles[index]
        return ArticleViewModel(article)
    }
}


//articleViewModel represent only one article
struct ArticleViewModel {
    let article:Article
    
    init(_ article:Article){
        self.article = article
    }
    
    var title: String {return article.title}
    var description:String {return article.description ?? "no-description"}
    var urlToImage: String {return article.urlToImage ?? "no-image"}
    var url: String {return article.url ?? "no-url"}
}
