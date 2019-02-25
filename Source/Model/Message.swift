
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation

class Message: TwilioResponse {
    var from: String?
    var to: String?
    var body: String?
    var status: String?
    var dateSent: Date?
    var direction: String?
    
    override func update(dictionary: [AnyHashable : AnyObject]) {
        self.to = dictionary.jsonMap("to")
        self.from = dictionary.jsonMap("from")
        self.body = dictionary.jsonMap("body")
        self.status = dictionary.jsonMap("status")
        self.dateSent = dictionary.jsonMap("date_sent")
        self.direction = dictionary.jsonMap("direction")
        super.update(dictionary: dictionary)
    }
    
    override func serialize() -> [AnyHashable:AnyObject] {
        var dictionary: [AnyHashable:AnyObject] = [:]
        dictionary["to"] = to as AnyObject
        dictionary["from"] = from as AnyObject
        dictionary["body"] = body as AnyObject
        dictionary["status"] = status as AnyObject
        dictionary["date_sent"] = dateSent as AnyObject
        dictionary["direction"] = direction as AnyObject
        return dictionary
    }

    public var debugDescription: String {
        return "<Message to:\(self.to ?? "") from:\(self.from ?? "") body:\(self.body ?? "") date:\(String(describing: self.dateSent))>"
    }
    
    convenience init(from: String, to: String, body: String) {
        self.init()
        self.from = from
        self.to = to
        self.body = body
    }
}
