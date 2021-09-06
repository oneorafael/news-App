//
//  ReadLaterViewModel.swift
//  news App
//
//  Created by Rafael Oliveira on 04/09/21.
//

import Foundation
import CoreData
import UIKit
struct ReadLaterListViewModel {
    
    var news:[News] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var numberOfSection: Int {return 1}
    func numberOfRowsInSection(section:Int) -> Int {
        return news.count
    }
    
    mutating func loadNews(onComplete:@escaping([News])->()){
        let request: NSFetchRequest<News> = News.fetchRequest()
        do {
            news = try context.fetch(request)
            onComplete(news)
        } catch  {
            print("error fetching data from context")
        }
        
    }
    
    func removeNews(at indexPath:Int) {
       context.delete(news[indexPath])
        do {
            try context.save()
        } catch let error {
            print("Error deleting - \(error.localizedDescription)")
        }
    }
    
    func removeAll(){
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")

        // Configure Fetch Request
        fetchRequest.includesPropertyValues = false

        do {
            let items = try context.fetch(fetchRequest) as! [NSManagedObject]

            for item in items {
                context.delete(item)
            }

            // Save Changes
            try? context.save()

        } catch let error{
            print("error to delete all data from coredata")
            print(error.localizedDescription)
        }
    }
}
