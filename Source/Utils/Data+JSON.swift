
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation

extension Data {
    func JSON() -> [AnyHashable:AnyObject]? {
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: self, options : .allowFragments) as? [AnyHashable:AnyObject]
            {
                return jsonArray
            } else {
                print("Failed to decode json")
            }
        } catch let error as NSError {
            print(error)
        }
        
        return nil
    }
}
