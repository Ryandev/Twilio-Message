
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation

class Messages: TwilioResponse {
    
    var messages = [Message]()
    
    override func update(dictionary: [AnyHashable:AnyObject]) {
        messages.removeAll()
        
        let messagesArr = dictionary["messages"] as? [[AnyHashable:AnyObject]]

        for messageDict in messagesArr ?? [] {
            let message = Message()
            message.update(dictionary: messageDict)
            messages.append(message)
        }

        super.update(dictionary: dictionary)
    }
    
    override func serialize() -> [AnyHashable:AnyObject] {
        var messagesArr:[[AnyHashable:AnyObject]] = []
        
        for message in self.messages {
            messagesArr.append(message.serialize())
        }
        
        return ["messages":messagesArr as AnyObject]
    }

    public var debugDescription: String {
        return "<Messages \(messages)>"
    }
}
