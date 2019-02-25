
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation

class TwilioResponse: RestInMapper, RestOutMapper {
    var errorMessage: String?
    var errorCode: Int?
    
    func update(dictionary: [AnyHashable : AnyObject]) {
        errorMessage = dictionary.jsonMap("error_message")
        errorCode = dictionary.jsonMap("error_code")
    }
    
    func serialize() -> [AnyHashable:AnyObject] {
        return [:]
    }
}
