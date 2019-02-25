
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import RxSwift
import KeychainSwift

class LoginViewModel : ViewModel {
    let applicationSID: Variable<String> = Variable("")
    let authToken: Variable<String> = Variable("")
    let rememberMe: Variable<Bool> = Variable(false)
    let loginButtonEnabled: Variable<Bool> = Variable(false)
    let loginRequested: PublishSubject<Void> = PublishSubject()
    let helpRequested: PublishSubject<Void> = PublishSubject()

    let disposeBag = DisposeBag()
    
    override init() {
        super.init()
        
        let appIdValid = applicationSID.asObservable().map({ (appId) -> Bool in
            return appId.count >= 4
        })
        
        let authTokenValid = authToken.asObservable().map({ (authToken) -> Bool in
            return authToken.count >= 4
        })
        
        Observable.combineLatest(appIdValid, authTokenValid)
            .map({ (appIdValid, authTokenValid) -> Bool in
                return appIdValid && authTokenValid
            })
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
            .drive(self.loginButtonEnabled)
            .disposed(by: disposeBag)
    }
}
