//
//  AlertNotification
//  news App
//
//  Created by Rafael Oliveira on 10/09/21.
//

import Foundation
import UIKit
extension UIViewController {
    func displayNotificationAndDismissIn2Second(notificationTitle:String, notificationMessage: String) {
        let alert = UIAlertController(title: notificationTitle, message: notificationMessage, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        // change to desired number of seconds (in this case 5 seconds)
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
          // your code with delay
          alert.dismiss(animated: true, completion: nil)
        }
    }

}
