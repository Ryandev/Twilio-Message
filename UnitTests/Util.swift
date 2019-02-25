
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
        let val = _getTestKey(Bundle.kAccountSID)
        print("Retrieved value: \(val) for accountSID")
        return val
    }

    var authToken: String {
        let val = _getTestKey(Bundle.kAuthToken)
        print("Retrieved value: \(val) for authToken")
        return val
    }

    var toSMSNumber: String {
        let val = _getTestKey(Bundle.kToSMSNumber)
        print("Retrieved value: \(val) for toSMSNumber")
        return val
    }
    
    fileprivate func _getTestKey(_ testKey: String) -> String {
        let envValue = ProcessInfo.processInfo.environment[testKey]
        let bundleValue = self.infoDictionary?[testKey] as? String
        let returnValue = envValue ?? ( bundleValue ?? "" )
        return returnValue
    }
    
    fileprivate static let kAccountSID = "accountSID"
    fileprivate static let kAuthToken = "authToken"
    fileprivate static let kToSMSNumber = "toSMSNumber"
}
