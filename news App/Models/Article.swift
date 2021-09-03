//
//  Article.swift
//  news App
//
//  Created by Rafael Oliveira on 31/08/21.
//

import Foundation

struct ArticleList: Decodable {
    let articles: [Article]
}
struct Article: Decodable {
    let title: String
    let description:String?
    let urlToImage: String?
    let url: String?
}
