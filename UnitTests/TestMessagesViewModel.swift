
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import XCTest
import RxSwift

@testable import Twilio_Message

class TestMessagesViewModel: XCTestCase {
    let disposeBag = DisposeBag()
    var messageViewModel: ListMessageViewModel? /* needed to prevent early deinit from async callback */
    
    func testItems() {
        let expectation = XCTestExpectation(description: "\(#function)")
        
        let accSID = Bundle.testBundle.accountSID
        let authToken = Bundle.testBundle.authToken
        
        API.shared
            .getAccounts(accSID: accSID, authKey: authToken)
            .subscribe(onSuccess: { [weak self] (accounts) in
                guard let self = self else { return }

                XCTAssert(accounts.accounts.count > 0)
                let account = accounts.accounts[0]
                let messageViewModel = ListMessageViewModel(account: account)
                
                messageViewModel.items
                    .asObservable()
                    .skip(1) /* ignore 1st value as this is a BehaviourSubject */
                    .subscribe(onNext: { (items) in
                        XCTAssert(items.count > 0)
                        expectation.fulfill()
                    })
                    .disposed(by: self.disposeBag)
                
                messageViewModel.refresh()
                
                self.messageViewModel = messageViewModel
            }) { (error) in
                XCTFail("Failed to get account error:\(error)")
                expectation.fulfill()
            }
            .disposed(by: disposeBag)
        
        self.wait(for: [expectation], timeout: 20)
    }
}
