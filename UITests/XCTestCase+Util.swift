
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import XCTest

extension XCTestCase {

    func waitForElementToAppear(_ elem: XCUIElement) {
        waitForElementToAppear(elem, wait:10)
    }
    
    func waitForElementToAppear(_ elem: XCUIElement, wait: TimeInterval) {
        if elem.exists { return }
        
        let predicate = NSPredicate(format: "exists == true")
        let exp = XCTNSPredicateExpectation(predicate: predicate, object: elem)
        exp.expectationDescription = "waiting for \(elem) for:\(wait) seconds for element to exist"
        
        self.wait(for: [exp], timeout: wait)
    }
    
    func waitForElementToDisappear(_ elem: XCUIElement) {
        waitForElementToDisappear(elem, wait:10)
    }
    
    func waitForElementToDisappear(_ elem: XCUIElement, wait: TimeInterval) {
        if !elem.exists { return }
        
        let predicate = NSPredicate(format: "exists == false")
        let exp = XCTNSPredicateExpectation(predicate: predicate, object: elem)
        exp.expectationDescription = "waiting for \(elem) for:\(wait) seconds for element to cease"
        
        self.wait(for: [exp], timeout: wait)
    }
}
