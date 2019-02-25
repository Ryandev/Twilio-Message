
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import XCTest

class Test_Welcome: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = ["ShowWelcomeOnBoot"]
        app.launch()
        XCTAssertTrue(app.wait(for: .runningForeground, timeout: 20))
        XCTAssertEqual(app.state, .runningForeground)
    }

    func testWelcomeButtonStart() {
        Test_Welcome.skipOverWelcome(app: app, from: self)
    }
    
    static func skipOverWelcome(app: XCUIApplication, from testCase: XCTestCase) {
        let welcomeUI = UIWelcome(app)
        
        guard welcomeUI.startButton.isVisible(in: app) else { return }
        
        do {
            try welcomeUI.skip()
        }
        catch(let error) {
            XCTFail("Error occurred tapping welcome-begin \(error)")
        }
        
        testCase.waitForElementToDisappear(welcomeUI.startButton)
    }
}
