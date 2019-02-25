
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import XCTest
import RxSwift

enum WelcomeError: Error, CustomStringConvertible, LocalizedError {
    case noWelcomeUI
    
    var description: String {
        switch self {
        case .noWelcomeUI:
            return "No welcome UI"
        }
    }
}

class UIWelcome {
    let application: XCUIApplication
    
    init(_ application: XCUIApplication) {
        self.application = application
    }
    
    var startButton: XCUIElement {
        return application.buttons["button_start"].firstMatch
    }

    func skip() throws {
        let isShowingWelcome = startButton.isVisible(in: application)

        guard isShowingWelcome else {
            throw WelcomeError.noWelcomeUI
        }
        
        startButton.tap()
    }
}
