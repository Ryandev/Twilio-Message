
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation

class Accounts: TwilioResponse {
    
    var accounts = [Account]()
    
    override func update(dictionary: [AnyHashable:AnyObject]) {
        accounts.removeAll()
        
        let accountArr = dictionary["accounts"] as? [[AnyHashable:AnyObject]]
        
        for accountDict in accountArr ?? [] {
            let account = Account()
            account.update(dictionary: accountDict)
            accounts.append(account)
        }
        
        super.update(dictionary: dictionary)
    }
    
    override func serialize() -> [AnyHashable:AnyObject] {
        var accountsArr:[[AnyHashable:AnyObject]] = []
        
        for account in self.accounts {
            accountsArr.append(account.serialize())
        }
        
        return ["accounts":accountsArr as AnyObject]
    }

    public var debugDescription: String {
        return "<Accounts \(accounts)>"
    }
}
