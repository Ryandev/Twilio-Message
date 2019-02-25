
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import UIKit

extension UINavigationController {
    func pushFade(to pushVC: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        self.view.layer.add(transition, forKey:nil)
        self.pushViewController(pushVC, animated: false)
    }
}
