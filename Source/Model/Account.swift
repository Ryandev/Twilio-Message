
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation

class Account: TwilioResponse {
    var sid: String?
    var parentAccountSID: String?
    var dateCreated: Date?
    var dateLastUsed: Date?
    var status: String?
    var friendlyName: String?
    var type: String?
    var authToken: String?
    
    override func update(dictionary: [AnyHashable : AnyObject]) {
        self.sid = dictionary.jsonMap("sid")
        self.parentAccountSID = dictionary.jsonMap("owner_account_sid")
        self.dateCreated = dictionary.jsonMap("date_created")
        self.dateLastUsed = dictionary.jsonMap("date_updated")
        self.status = dictionary.jsonMap("status")
        self.friendlyName = dictionary.jsonMap("friendly_name")
        self.type = dictionary.jsonMap("type")
        self.authToken = dictionary.jsonMap("auth_token")

        super.update(dictionary: dictionary)
    }
    
    override func serialize() -> [AnyHashable:AnyObject] {
        var dictionary: [AnyHashable:AnyObject] = [:]
        dictionary["SID"] = sid as AnyObject
        dictionary["OwnerAccountSid"] = parentAccountSID as AnyObject
        dictionary["DateCreated"] = dateCreated?.restoreValue() as AnyObject
        dictionary["Status"] = status as AnyObject
        dictionary["FriendlyName"] = friendlyName as AnyObject
        dictionary["Type"] = type as AnyObject
        dictionary["AuthToken"] = authToken as AnyObject
        return dictionary
    }

    public var debugDescription: String {
        return "<Account sid:\(self.sid ?? "") status:\(self.status ?? "") name:\(self.friendlyName ?? "")>"
    }
}
