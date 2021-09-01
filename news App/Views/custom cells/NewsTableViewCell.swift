//
//  NewsTableViewCell.swift
//  news App
//
//  Created by Rafael Oliveira on 31/08/21.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    //MARK: - IBOutlets
   
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var NewsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
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
        
        //get Image from url
        // Create URL
        if Article.urlToImage != nil {
            let url = URL(string: Article.urlToImage!)
            // Fetch Image Data
            if let data = try? Data(contentsOf: url!) {
                // Create Image and Update Image View
                DispatchQueue.main.async {
                    self.NewsImage.image = UIImage(data: data)
                }
            }
        }
    }
    
}
