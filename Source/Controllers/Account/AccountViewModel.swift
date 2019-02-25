
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import RxSwift
import KeychainSwift

class AccountViewModel : ViewModel {
    let items: Variable<[AccountViewModelItem]> = Variable([])
    let accountSelected: PublishSubject<AccountViewModelItem?> = PublishSubject()
    let listError: PublishSubject<String> = PublishSubject()
    let isBusy: Variable<Bool> = Variable(false)

    let applicationSID: String
    let authToken: String
    fileprivate let disposeBag = DisposeBag()
    
    init(applicationSID: String, authToken: String) {
        self.applicationSID = applicationSID
        self.authToken = authToken
        super.init()
    }
    
    func refresh() {
        isBusy.value = true
        
        API.shared
            .getAccounts(accSID: applicationSID, authKey: authToken)
            .subscribe({ [weak self] (event) in
                switch event {
                case .success(let accounts):
                    var newItems: [AccountViewModelItem] = []

                    let addAccounts = accounts.accounts
                        .filter({ $0.status == "active" })
                        .sorted(by: { (acc1, acc2) -> Bool in
                            let isSub1 = acc1.friendlyName?.hasPrefix("SubAccount") ?? false
                            let isSub2 = acc2.friendlyName?.hasPrefix("SubAccount") ?? false
                            if ( isSub1 && isSub2 ) {
                                return (acc1.dateLastUsed ?? Date()) < (acc2.dateLastUsed ?? Date())
                            } else {
                                return acc1.friendlyName ?? "" > acc2.friendlyName ?? ""
                            }
                        })

                    var subAccIndex = 1

                    for account in addAccounts {
                        let itemSubAccIndex = (account.friendlyName?.hasPrefix("SubAccount") ?? false) ? subAccIndex : 0
                        let acc = AccountViewModelItem(account: account, subAccountIndex: itemSubAccIndex)
                        subAccIndex += min(itemSubAccIndex,1)
                        newItems.append(acc)
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
    
    func itemAtIndex(_ idx: Int) -> AccountViewModelItem? {
        guard idx < items.value.count else { return nil }
        return items.value[idx]
    }
}
