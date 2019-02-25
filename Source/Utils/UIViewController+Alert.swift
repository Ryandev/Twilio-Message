
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import UIKit

extension UIViewController {
    func showErrorMessage(message: String) {
        showAlert(title: nil, message: message, buttons:["OK"])
    }
    
    func showAlert(title: String?, message: String, buttons: [String]?) {
        let alert = UIAlertController(title: title ?? "", message: message, preferredStyle: .alert)
        
        for buttonTitle in buttons ?? ["OK"] {
            alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                    
                }}))
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}
