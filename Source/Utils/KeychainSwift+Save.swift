
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import KeychainSwift

extension KeychainSwift {

    final var applicationSID: String? {
        get {
            return _getKey(key: .key_applicationSID)
        }
        set(new) {
            _setKey(key: .key_applicationSID, value: new)
        }
    }

    final var authKey: String? {
        get {
            return _getKey(key: .key_authKey)
        }
        set(new) {
            _setKey(key: .key_authKey, value: new)
        }
    }
    
    /* pragma mark - private */

    fileprivate func _getKey(key: String) -> String? {
        return get(key)
    }
    
    fileprivate func _setKey(key: String, value: String?) {
        if let setValue = value {
            set(setValue, forKey: key)
        } else {
            delete(key)
        }
    }
    
}

fileprivate extension String {
    static let key_applicationSID = "applicationSID"
    static let key_authKey = "authKey"
}
