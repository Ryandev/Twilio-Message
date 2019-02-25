
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import RxSwift

class ListMessageViewModel : ViewModel {
    let items: Variable<[ListMessageViewModelItem]> = Variable([])
    let messageSelected: PublishSubject<ListMessageViewModelItem?> = PublishSubject()
    let composeSelected: PublishSubject<AnyObject?> = PublishSubject()
    let listError: PublishSubject<String> = PublishSubject()
    let isBusy: Variable<Bool> = Variable(false)

    let account: Account
    fileprivate let disposeBag = DisposeBag()
    
    init(account: Account) {
        self.account = account
        super.init()
    }
    
    func refresh() {
        isBusy.value = true
        
        API.shared
            .getMessages(accSID: account.sid ?? "", authKey: account.authToken ?? "")
            .subscribe({ [weak self] (event) in
                switch event {
                case .success(let messages):
                    var newItems: [ListMessageViewModelItem] = []
                    
                    for message in messages.messages {
                        let item = ListMessageViewModelItem(message: message)
                        newItems.append(item)
                    }
                    
                    if newItems.count == 0 {
                        let item = ListMessageViewModelItem(from: NSLocalizedString("No messages yet!", comment: ""), to: "", body: "", date: "")
                        newItems.append(item)
                    }
                    
                    self?.items.value = newItems
                    
                case .error(let error):
                    let errorMessage = error.localizedDescription
                    self?.listError.on(.next(errorMessage))
                }
                
                self?.isBusy.value = false
            })
            .disposed(by: disposeBag)
    }
    
    func itemAtIndex(_ idx: Int) -> ListMessageViewModelItem? {
        guard idx < items.value.count else { return nil }
        return items.value[idx]
    }
}
