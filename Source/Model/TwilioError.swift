
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation

class TwilioError: Error, RestInMapper, CustomStringConvertible, LocalizedError {
    var message = ""
    var code = 0
    
    func update(dictionary: [AnyHashable : AnyObject]) {
        message = dictionary.jsonMap("error_message") ?? dictionary.jsonMap("message") ?? ""
        code = dictionary.jsonMap("error_code") ?? dictionary.jsonMap("code") ?? 0
    }
    
    static func errorFromResponse(_ dictionary: [AnyHashable : AnyObject]) -> TwilioError? {
        let error = TwilioError()
        error.update(dictionary: dictionary)
        return error.code != 0 ? error : nil
    }
    
    var description: String {
        return code != 0 ? message : "No error"
    }
    
    var localizedDescription: String {
        return self.description
    }
    
    var errorDescription: String? {
        return self.description
    }
}
