
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import UIKit

class ViewControllerBase : UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupStyling()
    }
    
    func setupStyling() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)

        let theme = Theme.default

        let navBar = self.navigationController?.navigationBar
        navBar?.tintColor = theme.navigationBarTextColor
        navBar?.barTintColor = theme.navigationBarBackgroundColor
        navBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor:theme.navigationBarTextColor]
        
        let navItem = self.navigationController?.navigationItem
        navItem?.leftBarButtonItem?.tintColor = theme.navigationBarTextColor
        navItem?.rightBarButtonItem?.tintColor = theme.navigationBarTextColor
        navItem?.backBarButtonItem?.tintColor = theme.navigationBarTextColor
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
