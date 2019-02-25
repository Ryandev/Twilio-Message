
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import XCTest

enum LoginError: Error, CustomStringConvertible, LocalizedError {
    case noLoginUI
    
    var description: String {
        switch self {
        case .noLoginUI:
            return "No login UI"
        }
    }
}

class UILogin {
    let application: XCUIApplication
    
    init(_ application: XCUIApplication) {
        self.application = application
    }
    
    var loginButton: XCUIElement {
        return application.buttons["button_login"].firstMatch
    }
    
    var textFieldApplicationSID: XCUIElement {
        return application.textFields["textfield_applicationsid"].firstMatch
    }
    
    var textFieldAuthToken: XCUIElement {
        return application.textFields["textfield_authkey"].firstMatch
    }
    
    func login(accountSID: String, authToken: String) throws {
        guard loginButton.isVisible(in: application) else {
            throw LoginError.noLoginUI
        }
        
        guard textFieldAuthToken.isVisible(in: application) else {
            throw LoginError.noLoginUI
        }

        guard textFieldApplicationSID.isVisible(in: application) else {
            throw LoginError.noLoginUI
        }
        
        textFieldApplicationSID.tap()
        application.pressBackSpace(count: 127)
        application.typeText(accountSID)
        
        textFieldAuthToken.tap()
        application.pressBackSpace(count: 127)
        application.typeText(authToken)

        loginButton.tap()
    }
}
