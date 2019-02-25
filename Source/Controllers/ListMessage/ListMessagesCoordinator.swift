
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import UIKit
import RxSwift

class ListMessageCoordinator : Coordinator {
    var viewModel: ListMessageViewModel
    let account: Account
    
    let disposeBag = DisposeBag()
    
    init(parent: Coordinator?, account: Account) {
        viewModel = ListMessageViewModel(account: account)
        self.account = account

        super.init(parent: parent)

        let vcIdentifier = String(describing: ListMessageViewController.self)
        let vc = UIStoryboard.main.instantiateViewController(withIdentifier: vcIdentifier) as! ListMessageViewController
        vc.viewModel = viewModel
        viewController = vc
        
        viewModel.composeSelected
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (sender) in
                self?._showCompose()
            })
            .disposed(by: disposeBag)
    }
    
    fileprivate func _showCompose() {
        let coord = ComposeCoordinator(parent: self, account: self.account)
        coord.start()
        
        coord.viewModel.composeError
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] (_) in
                guard let self = self else { return }
                self.viewModel.refresh()
                self.children.removeLast()
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.view.window?.showToastSuccess(message: "Message Sent!")
            }
            .disposed(by: coord.viewModel.disposeBag)
    }
}
