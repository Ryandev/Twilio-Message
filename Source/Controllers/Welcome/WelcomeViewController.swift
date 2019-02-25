
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import UIKit
import RxSwift
import RxCocoa

class WelcomeViewController: ViewControllerBase {
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel: WelcomeViewModel?
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewModel = viewModel {
            _linkViewModel(viewModel)
        }
    }
    
    fileprivate func _linkViewModel(_ viewModel: WelcomeViewModel ) {
        loginButton.rx
            .controlEvent(.touchUpInside)
            .asDriver()
            .drive(viewModel.loginButtonTapped)
            .disposed(by: disposeBag)
    }
    
    override func setupStyling() {
        super.setupStyling()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

