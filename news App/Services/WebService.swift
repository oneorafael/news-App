//
//  WebService.swift
//  news App
//
//  Created by Rafael Oliveira on 31/08/21.
//

import Alamofire

class WebService {
    //check internet connection using NetworkReachabilityManager (Alamofire)
    class var isConnectedToInternet:Bool {
            return NetworkReachabilityManager()!.isReachable
        
    }
    
    // download data from News.org API
    func getData(url:URL, completionHandler:@escaping([Article])->()){
        if K.apiKey.isEmpty {
                print("Please set a developer key and run again")
            } else {
                AF.request(url).response { data in
                    guard let data = data.data else {return}
                    let articleArray = try? JSONDecoder().decode(ArticleList.self, from: data)
                    if let articleArray = articleArray {
                        completionHandler(articleArray.articles)
                    }
                }
            }
        }
    }
