
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import XCTest
import RxSwift

@testable import Twilio_Message

class TestAPIMessages: XCTestCase {
    let disposeBag = DisposeBag()
    
    func testGetMessagesSuccess() {
        let expectation = XCTestExpectation(description: "\(#function)")
        
        let accSID = Bundle.testBundle.accountSID
        let authToken = Bundle.testBundle.authToken
        
        API.shared
            .getMessages(accSID: accSID, authKey: authToken)
            .subscribe({ (event) in
                switch event {
                case .error(let error):
                    XCTFail(error.localizedDescription)
                case .success(_):
                    print("\(#function) - success")
                }
                
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        self.wait(for: [expectation], timeout: 20)
    }
    
    func testGetMessagesFailure() {
        let expectation = XCTestExpectation(description: "\(#function)")
        
        let accSID = UUID().uuidString
        let authToken = UUID().uuidString
        
        API.shared
            .getMessages(accSID: accSID, authKey: authToken)
            .subscribe({ (event) in
                switch event {
                case .error(_):
                    print("\(#function) - success")
                case .success(_):
                    XCTFail("Get messages succeeded with bad credentials sid:\(accSID) token:\(authToken)")
                }
                
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        self.wait(for: [expectation], timeout: 20)
    }
}
