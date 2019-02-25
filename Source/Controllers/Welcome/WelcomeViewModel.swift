
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import RxSwift
import RxCocoa

class WelcomeViewModel : ViewModel {
    var loginButtonTapped: PublishSubject<Void> = PublishSubject()
    
    let disposeBag = DisposeBag()
}
