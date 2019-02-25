
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation

extension Reachability {
    var hasConnection: Bool {
        return (self.connection == .wifi) || (self.connection == .cellular)
    }
}
