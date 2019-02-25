
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import UIKit
import RxSwift

class WelcomeCoordinator : Coordinator {
    var viewModel: WelcomeViewModel
    
    override init(parent: Coordinator?) {
        viewModel = WelcomeViewModel()

        super.init(parent: parent)

        let vcIdentifier = String(describing: WelcomeViewController.self)
        let vc = UIStoryboard.main.instantiateViewController(withIdentifier: vcIdentifier) as! WelcomeViewController
        vc.viewModel = viewModel
        viewController = vc

        viewModel.loginButtonTapped
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                guard let self = self else { return }
                let coord = LoginCoordinator(parent: self)
                coord.start(fade: true)
            }
            .disposed(by: viewModel.disposeBag)
    }
}
