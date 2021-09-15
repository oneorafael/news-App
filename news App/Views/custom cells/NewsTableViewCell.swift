//
//  NewsTableViewCell.swift
//  news App
//
//  Created by Rafael Oliveira on 31/08/21.
//

import UIKit
import CoreData
import Alamofire

class NewsTableViewCell: UITableViewCell {
    //MARK: - IBOutlets
   
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var NewsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bookmarkBtn: UIButton!
    var url: String?
    var imgUrl:String?
    var parentVC: UITableViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 10
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.shadowOpacity = 0.2
        cellView.layer.shadowRadius = 3.0
        cellView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(Article:Article){
        titleLabel.text = Article.title
        descriptionLabel.text = Article.description
        url = Article.url
        imgUrl = Article.urlToImage
        if Article.urlToImage != nil {
            let url = URL(string: Article.urlToImage!)!
            AF.request(url).response { response in
                guard let image = response.data else {return}
                DispatchQueue.main.async {
                    self.NewsImage.image = UIImage.init(data: image)
                }
            }
           
        }
        bookmarkBtn.addTarget(self, action: #selector(bookmarkButtonTapped(sender:)), for: .touchUpInside)
    }
    
    @objc
    func bookmarkButtonTapped(sender:UIButton){
        print("tocado: \(sender.tag)\n")
        guard let articleTitle = titleLabel.text else {return}
        guard let articleDescription = descriptionLabel.text else {return}
        guard let _url = url else {return}
        let saveArticle = Article(title: articleTitle, description: articleDescription, urlToImage: imgUrl, url: _url)
        save(Article: saveArticle)
      
        
    }
    
    func save(Article:Article) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let news = News(context: context)
        news.newsTitle = Article.title
        news.newsDescription = Article.description
        news.newsURL = Article.url!
        news.newsImageURL = Article.urlToImage
        print("\(Article.title),\(Article.description!),\(Article.url!)")
        
        do {
            try? context.save()
            print("salvo")
            parentVC.displayNotificationAndDismissIn2Second(notificationTitle: "Noticia Salva", notificationMessage: "Sua noticia foi salva com sucesso")
            
        }
    }
    
    
    
}
