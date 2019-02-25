
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import XCTest

class Util {
    
}

extension Bundle {
    static var testBundle: Bundle {
        return Bundle(for: Util.self)
    }
}

extension Bundle {
    var accountSID: String {
        return _getTestKey(Bundle.kAccountSID)
    }
    
    var authToken: String {
        return _getTestKey(Bundle.kAuthToken)
    }
    
    fileprivate func _getTestKey(_ testKey: String) -> String {
        let envValue = ProcessInfo.processInfo.environment[testKey]
        let bundleValue = self.infoDictionary?[testKey] as? String
        let returnValue = envValue ?? ( bundleValue ?? "" )
        return returnValue
    }
    
    fileprivate static let kAccountSID = "accountSID"
    fileprivate static let kAuthToken = "authToken"
}
