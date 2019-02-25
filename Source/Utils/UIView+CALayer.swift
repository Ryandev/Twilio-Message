
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import UIKit

extension UIView {
    @IBInspectable var maskToBounds: Bool {
        get {
            return self.layer.masksToBounds
        }
        set(newVal) {
            self.layer.masksToBounds = newVal
        }
    }
    
}
