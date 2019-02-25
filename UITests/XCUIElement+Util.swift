
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import XCTest

extension XCUIElement {
    func isVisible(in element: XCUIElement) -> Bool {
        guard self.exists else { return false }
        let isZeroFrame = self.frame.isEmpty
        let frameOverlap = element.frame.intersects(self.frame)
        return !isZeroFrame && frameOverlap
    }
    
    func forceTap() {
        self.isHittable ? self.tap() : self.tap(at: CGPoint(x: 0.5, y: 0.5))
    }
    
    func tap(at point: CGPoint) {
        let coord = self.coordinate(withNormalizedOffset: CGVector(dx: point.x, dy: point.y))
        coord.tap()
    }
    
    func pressBackSpace(count: UInt) {
        var deleteString = ""
        
        for _ in 0...count {
            deleteString += XCUIKeyboardKey.delete.rawValue
        }
        
        self.typeText(deleteString)
    }
}
