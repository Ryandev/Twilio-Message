
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import UIKit
import ObjectiveC

extension UIWindow {
    var isShowingBusyDialog: Bool {
        let view = self.viewWithTag(UIWindow.kBusyViewTag)
        return view != nil
    }
    
    func showBusyDialog() {
        let containerView = UIView(frame: self.bounds)
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        containerView.isUserInteractionEnabled = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.tag = UIWindow.kBusyViewTag
        containerView.alpha = 0
        
        self.addSubview(containerView)
        
        containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1, constant: 0).isActive = true
        containerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1, constant: 0).isActive = true
        containerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0.0).isActive = true
        containerView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0.0).isActive = true

        let spinner = UIActivityIndicatorView(style: .white)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(spinner)
        spinner.widthAnchor.constraint(equalToConstant: 30).isActive = true
        spinner.heightAnchor.constraint(equalToConstant: 30).isActive = true
        spinner.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0.0).isActive = true
        spinner.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0.0).isActive = true
        
        spinner.startAnimating()
        
        UIView.animate(withDuration: UIWindow.kAnimationDuration,
                       animations: {
            containerView.alpha = 1
        })
    }
    
    func hideBusyDialog() {
        let view = self.viewWithTag(UIWindow.kBusyViewTag)
        
        UIView.animate(withDuration: UIWindow.kAnimationDuration,
                       animations: {
            view?.alpha = 0
        }) { (didComplete) in
            view?.removeFromSuperview()
        }
    }
    
    static fileprivate var kAnimationDuration: TimeInterval = 0.3
    static fileprivate var kBusyViewTag = 1234
    static fileprivate var kIsBusyKey = "IsBusyDialog"
}
