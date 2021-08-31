//
//  WebService.swift
//  news App
//
//  Created by Rafael Oliveira on 31/08/21.
//

import Foundation
class WebService {
    
    func getData(url:URL, completionHandler:@escaping([Any]?)->()){
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
        // receber os dados da API
                guard let data = data else {return}
                print(data.count)
        // Converter em um objeto da model
        // Enviar para a ViewController
            }
        }.resume()
    }
}
