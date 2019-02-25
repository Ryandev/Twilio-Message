
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import UIKit
import RxSwift

class AccountCoordinator : Coordinator {
    var viewModel: AccountViewModel
    
    let disposeBag = DisposeBag()

    init(parent: Coordinator?, applicationSID: String, authToken: String) {
        viewModel = AccountViewModel(applicationSID: applicationSID, authToken: authToken)

        super.init(parent: parent)
        
        viewModel.accountSelected
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (accountViewModel) in
                guard let accountViewModel = accountViewModel else { return }
                let coord = ListMessageCoordinator(parent: self, account: accountViewModel.account)
                coord.start()
            })
            .disposed(by: disposeBag)

        let vcIdentifier = String(describing: AccountViewController.self)
        let vc = UIStoryboard.main.instantiateViewController(withIdentifier: vcIdentifier) as! AccountViewController
        vc.viewModel = viewModel
        viewController = vc
    }
}
