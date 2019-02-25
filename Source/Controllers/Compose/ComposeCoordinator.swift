
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import UIKit
import RxSwift

class ComposeCoordinator : Coordinator {
    var viewModel: ComposeViewModel
    let account: Account
    
    init(parent: Coordinator?, account: Account) {
        self.account = account
        viewModel = ComposeViewModel(account: account)

        super.init(parent: parent)

        let vcIdentifier = String(describing: ComposeViewController.self)
        let vc = UIStoryboard.main.instantiateViewController(withIdentifier: vcIdentifier) as! ComposeViewController
        vc.viewModel = viewModel
        viewController = vc
    }
}
