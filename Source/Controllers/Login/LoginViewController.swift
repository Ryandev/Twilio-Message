
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import UIKit
import RxSwift

class LoginViewController: ViewControllerBase {
    @IBOutlet weak var applicationSID: UITextField!
    @IBOutlet weak var authToken: UITextField!
    @IBOutlet weak var applicationSIDHelpButton: UIButton!
    @IBOutlet weak var authTokenHelpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var rememberMeSwitch: UISwitch!

    var viewModel: LoginViewModel?
    fileprivate let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewModel = viewModel {
            _linkViewModel(viewModel)
        }
    }
    
    fileprivate func _linkViewModel(_ viewModel: LoginViewModel ) {
        applicationSID.text = viewModel.applicationSID.value

        applicationSID.rx
            .text
            .orEmpty
            .bind(to: viewModel.applicationSID)
            .disposed(by: disposeBag)
        
        viewModel.applicationSID
            .asDriver()
            .drive(applicationSID.rx.text)
            .disposed(by: disposeBag)

        authToken.text = viewModel.authToken.value

        authToken.rx
            .text
            .orEmpty
            .bind(to: viewModel.authToken)
            .disposed(by: disposeBag)
        
        viewModel.authToken
            .asDriver()
            .drive(authToken.rx.text)
            .disposed(by: disposeBag)

        rememberMeSwitch.rx.value
            .asObservable()
            .bind(to: viewModel.rememberMe)
            .disposed(by: disposeBag)

        loginButton.rx
            .controlEvent(.touchUpInside)
            .asDriver()
            .drive(viewModel.loginRequested)
            .disposed(by: disposeBag)
        
        viewModel.loginButtonEnabled
            .asDriver()
            .drive(loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.loginButtonEnabled
            .asObservable()
            .map({ $0 ? 1.0 : 0.7 })
            .asDriver(onErrorJustReturn: 0.7)
            .drive(loginButton.rx.alpha)
            .disposed(by: disposeBag)

        let sidButton = applicationSIDHelpButton.rx.controlEvent(.touchUpInside).asObservable()
        let tokenButton = authTokenHelpButton.rx.controlEvent(.touchUpInside).asObservable()
        Observable.merge(sidButton, tokenButton)
            .asDriver(onErrorJustReturn: ())
            .drive(viewModel.helpRequested)
            .disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        applicationSID.becomeFirstResponder()
    }
    
    override func setupStyling() {
        super.setupStyling()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

