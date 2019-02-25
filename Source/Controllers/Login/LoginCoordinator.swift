
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import UIKit
import RxSwift
import KeychainSwift

class LoginCoordinator : Coordinator {
    var viewModel: LoginViewModel
    
    let disposeBag = DisposeBag()
    let keychain = KeychainSwift()
    
    override init(parent: Coordinator?) {
        viewModel = LoginViewModel()
        viewModel.applicationSID.value = keychain.applicationSID ?? ""
        viewModel.authToken.value = keychain.authKey ?? ""

        super.init(parent: parent)

        let vcIdentifier = String(describing: LoginViewController.self)
        let vc = UIStoryboard.main.instantiateViewController(withIdentifier: vcIdentifier) as! LoginViewController
        vc.viewModel = viewModel
        viewController = vc
        
        viewModel.helpRequested
            .subscribe(onNext: { [weak self] (event) in
                guard let self = self else { return }
                
                let coord = HelpCoordinator(parent: self)
                coord.start(modal: false)
            })
            .disposed(by: disposeBag)
        
        viewModel.loginRequested
            .subscribe(onNext: { [weak self] (event) in
                guard let self = self else { return }
                
                let rememberMe = self.viewModel.rememberMe.value
                
                self.keychain.applicationSID = rememberMe ? self.viewModel.applicationSID.value : ""
                self.keychain.authKey = rememberMe ? self.viewModel.authToken.value : ""

                let coord = AccountCoordinator(parent: self, applicationSID: self.viewModel.applicationSID.value, authToken: self.viewModel.authToken.value)
                coord.start()
                /* we want the back button to say logout *not* login on the next page */
                coord.navigationController?.navigationBar.topItem?.title = "Logout";
                
                if rememberMe == false {
                    self.viewModel.applicationSID.value = ""
                    self.viewModel.authToken.value = ""
                }
            })
            .disposed(by: disposeBag)
    }
}
