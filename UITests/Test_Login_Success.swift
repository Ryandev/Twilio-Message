
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import XCTest

class Test_Login_Success: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.wait(for: .runningForeground, timeout: 20))
        XCTAssertEqual(app.state, .runningForeground)
    }
    
    func testLoginSuccess() {
        Test_Welcome.skipOverWelcome(app: app, from: self)
        
        let loginUI = UILogin(app)
        
        do {
            try loginUI.login(accountSID: Bundle.testBundle.accountSID, authToken: Bundle.testBundle.authToken)
        } catch(let error) {
            XCTFail("Error occurred tapping login \(error)")
        }
        
        self.waitForElementToDisappear(loginUI.loginButton)
    }
}
