
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import UIKit
import RxSwift

class HelpCoordinator : Coordinator {
    var viewModel: HelpViewModel
    
    override init(parent: Coordinator?) {
        viewModel = HelpViewModel()

        super.init(parent: parent)

        let vcIdentifier = String(describing: HelpViewController.self)
        let vc = UIStoryboard.main.instantiateViewController(withIdentifier: vcIdentifier) as! HelpViewController
        vc.viewModel = viewModel
        viewController = vc
    }
}
