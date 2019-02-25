
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import XCTest
import RxSwift

@testable import Twilio_Message

class TestComposeViewModel: XCTestCase {
    let disposeBag = DisposeBag()
    var composeViewModel: ComposeViewModel?
    
    func testSend() {
        let expectation = XCTestExpectation(description: "\(#function)")
        
        let accSID = Bundle.testBundle.accountSID
        let authToken = Bundle.testBundle.authToken
        
        API.shared
            .getAccounts(accSID: accSID, authKey: authToken)
            .subscribe(onSuccess: { [weak self] (accounts) in
                guard let self = self else { return }
                
                XCTAssert(accounts.accounts.count > 0)
                let composeViewModel = ComposeViewModel(account: accounts.accounts[0])
                
                composeViewModel.to.value = Bundle.testBundle.toSMSNumber
                composeViewModel.from.value = "test from"
                composeViewModel.body.value = "test body"
                composeViewModel.messageSent
                    .subscribe(onNext: { (_) in
                        expectation.fulfill()
                    }, onError: { (error) in
                        XCTFail("Message send failed \(error)")
                    })
                    .disposed(by: self.disposeBag)
                
                composeViewModel.sendSelected.onNext(Void())
                
                self.composeViewModel = composeViewModel
            }) { (error) in
                XCTFail("Failed to get account error:\(error)")
                expectation.fulfill()
            }
            .disposed(by: disposeBag)
        
        self.wait(for: [expectation], timeout: 20)
    }
}
