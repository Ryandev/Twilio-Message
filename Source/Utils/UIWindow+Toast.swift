
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import UIKit

extension UIWindow {
    func showToastSuccess(message: String) {
        showToast(message: message, color: UIWindow.kToastColorSuccess)
    }
    
    func showToastError(message: String) {
        showToast(message: message, color: UIWindow.kToastColorError)
    }
    
    func showToast(message: String, color: UIColor = UIColor.black, duration: TimeInterval = 4.5) {
        let label = UILabel()
        label.text = message
        label.backgroundColor = .clear
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let viewContainer = UIView()
        viewContainer.backgroundColor = color
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        viewContainer.alpha = 0
        
        viewContainer.addSubview(label)
        label.widthAnchor.constraint(equalTo: viewContainer.widthAnchor, multiplier: 0.8).isActive = true
        label.heightAnchor.constraint(equalTo: viewContainer.heightAnchor, multiplier: 0.8).isActive = true
        label.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor, constant: 0).isActive = true
        label.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor, constant: 1).isActive = true

        self.addSubview(viewContainer)
        
        viewContainer.heightAnchor.constraint(equalToConstant: UIWindow.kToastViewHeight).isActive = true
        viewContainer.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        viewContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        viewContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
        UIView.animate(withDuration: UIWindow.kToastFadeDuration,
                       animations: {
            viewContainer.alpha = 1
        })

        UIView.animate(withDuration: UIWindow.kToastFadeDuration,
                       delay: duration,
                       options: .curveEaseOut,
                       animations: {
            viewContainer.alpha = 0
        },
                       completion: { (completed) in
            viewContainer.removeFromSuperview()
        })
    }
    
    static let kToastViewHeight: CGFloat = 50
    static let kToastFadeDuration: TimeInterval = 0.3
    static let kToastColorError = UIColor(hex: "#EA0005")
    static let kToastColorSuccess = UIColor(hex: "#3F9C00")
}
