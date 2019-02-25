
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import RxSwift

class HelpViewModel : ViewModel {
    let helpURL: Variable<URL>
    
    override init() {
        let filePath = URL(fileURLWithPath: Bundle.main.bundlePath + "/html/help/index.html")
        helpURL = Variable(filePath)
        super.init()
    }
    
}
