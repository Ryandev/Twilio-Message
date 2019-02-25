
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation

extension Dictionary {
    func queryString() -> String {
        var pairStrings: [String] = []
        for (k,v) in self {
            pairStrings.append("\(k)=\(v)")
        }
        let str = pairStrings.joined(separator: "&")
        return str
    }
}
