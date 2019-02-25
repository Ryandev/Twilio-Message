
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation

extension Dictionary {
    func JSONData() -> Data {
        do {
            let data = try JSONSerialization.data(withJSONObject: self)
            return data
        } catch {
            return Data()
        }
    }
}
