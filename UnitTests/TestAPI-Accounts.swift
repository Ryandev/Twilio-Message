
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import XCTest
import RxSwift

@testable import Twilio_Message

class TestAPIAccounts: XCTestCase {
    let disposeBag = DisposeBag()
    
    func testGetAccountSuccess() {
        let expectation = XCTestExpectation(description: "\(#function)")
        
        let accSID = Bundle.testBundle.accountSID
        let authToken = Bundle.testBundle.authToken
        
        API.shared
            .getAccounts(accSID: accSID, authKey: authToken)
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
    
    func testGetAccountFailure() {
        let expectation = XCTestExpectation(description: "\(#function)")
        
        let accSID = UUID().uuidString
        let authToken = UUID().uuidString
        
        API.shared
            .getAccounts(accSID: accSID, authKey: authToken)
            .subscribe({ (event) in
                switch event {
                case .error(_):
                    print("\(#function) - success")
                case .success(_):
                    XCTFail("Get accounts succeeded with bad credentials sid:\(accSID) token:\(authToken)")
                }
                
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        self.wait(for: [expectation], timeout: 20)
    }
}
