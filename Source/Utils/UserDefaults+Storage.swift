
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation

extension UserDefaults {
    var bootCounter: Int {
        get {
            return self.integer(forKey: UserDefaults.kBootCounter)
        }
        set(newVal) {
            self.set(newVal, forKey: UserDefaults.kBootCounter)
        }
    }
    
    fileprivate static let kBootCounter = "BootCounter"
}
