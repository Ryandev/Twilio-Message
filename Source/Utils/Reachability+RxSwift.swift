
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation

extension Reachability {
    var hasConnection {
        return (reachability?.connection == .wifi) || (reachability?.connection == .cellular)
    }
}
