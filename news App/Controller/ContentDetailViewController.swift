//
//  ContentDetailViewController.swift
//  news App
//
//  Created by Rafael Oliveira on 14/09/21.
//

import UIKit
import Alamofire

class ContentDetailViewController: UIViewController {
//    MARK: - Properties & IBoutlet
    @IBOutlet weak var contentTitleLabel:UILabel!
    @IBOutlet weak var contentDescriptionLabel:UILabel!
    @IBOutlet weak var contentImageView:UIImageView!
    
    var article:Article?
    var news:News?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         displayNews()
    }
    
//  get data from previous view controller and display
    func displayNews(){
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
    
//  Download cover image using Alamofire request and display
    func loadImage(url:String){
        AF.request(url).response { response in
            guard let image = response.data else {return}
            DispatchQueue.main.async {
                self.contentImageView.image = UIImage.init(data: image)
            }
        }
    }

}
