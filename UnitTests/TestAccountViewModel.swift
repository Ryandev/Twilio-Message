
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import XCTest
import RxSwift

@testable import Twilio_Message

class TestAccountViewModel: XCTestCase {
    let disposeBag = DisposeBag()
    
    func testItems() {
        let expectation = XCTestExpectation(description: "\(#function)")
        
        let accSID = Bundle.testBundle.accountSID
        let authToken = Bundle.testBundle.authToken
        
        let account = AccountViewModel(applicationSID: accSID, authToken: authToken)
        
        account.items
            .asObservable()
            .skip(1) /* ignore 1st value as this is a BehaviourSubject */
            .subscribe(onNext: { (items) in
                XCTAssert(items.count > 0)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        account.refresh()
        
        self.wait(for: [expectation], timeout: 20)
    }
    
    func testError() {
        let expectation = XCTestExpectation(description: "\(#function)")
        
        let accSID = UUID().uuidString
        let authToken = UUID().uuidString

        let account = AccountViewModel(applicationSID: accSID, authToken: authToken)
        
        account.listError
            .subscribe(onNext: { (errorMessage) in
                XCTAssert(errorMessage.count > 0)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        account.refresh()

        self.wait(for: [expectation], timeout: 20)
    }
}
