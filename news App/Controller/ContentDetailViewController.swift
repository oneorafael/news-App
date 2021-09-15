//
//  ContentDetailViewController.swift
//  news App
//
//  Created by Rafael Oliveira on 14/09/21.
//

import UIKit
import Alamofire

class ContentDetailViewController: UIViewController {
    @IBOutlet weak var contentTitleLabel:UILabel!
    @IBOutlet weak var contentDescriptionLabel:UILabel!
    @IBOutlet weak var contentImageView:UIImageView!
    
    var article:Article?
    var news:News?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentTitleLabel.text = article?.title ?? news?.newsTitle
        contentDescriptionLabel.text = article?.description ?? news?.newsDescription
        if ((article?.urlToImage) != nil) {
            let url = (article?.urlToImage)!
            loadImage(url: url)
        }else {
            let url = (news?.newsImageURL)!
            loadImage(url: url)
        }

    }
    func loadImage(url:String){
        AF.request(url).response { response in
            guard let image = response.data else {return}
            DispatchQueue.main.async {
                self.contentImageView.image = UIImage.init(data: image)
            }
        }
    }

}
