
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import RxSwift

class ComposeViewModel : ViewModel {
    let to: Variable<String> = Variable("")
    let from: Variable<String> = Variable("")
    let body: Variable<String> = Variable("")
    let sendSelected: PublishSubject<Void> = PublishSubject()
    let composeError: PublishSubject<String> = PublishSubject()
    let messageSent: PublishSubject<Message> = PublishSubject()
    let isSendingMessage: Variable<Bool> = Variable(false)

    let disposeBag = DisposeBag()
    let account: Account
    
    init(account: Account) {
        self.account = account
        
        super.init()
        
        sendSelected
            .flatMap({ [weak self] (_) -> Single<Message> in
                guard let self = self else { return Single.just(Message()) }

                self.isSendingMessage.value = true
                let message = Message(from: self.from.value, to: self.to.value, body: self.body.value)
                return API.shared.sendMessage(from: self.account, message: message)
            })
            .subscribe({ [weak self] (event) in
                guard let self = self else { return }

                self.isSendingMessage.value = false

                switch event {
                case .completed, .next(_):
                    if let message = event.event.element {
                        self.messageSent.on(.next(message))
                    }
                case .error(let error):
                    let errorMessage = error.localizedDescription
                    self.composeError.on(.next(errorMessage))
                }
            })
            .disposed(by: disposeBag)
    }

}
