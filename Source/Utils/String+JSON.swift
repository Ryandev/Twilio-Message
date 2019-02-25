
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation

extension String {
    func JSON() -> [AnyHashable:AnyObject] {
        let data = self.data(using: .utf8)!
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [AnyHashable:AnyObject]
            {
                return jsonArray
            } else {
                print("bad json")
            }
        } catch let error as NSError {
            print(error)
        }
        
        return [:]
    }
}
