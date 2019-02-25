
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import UIKit

class Coordinator: NSObject {
    var navigationController: UINavigationController?
    var viewController: UIViewController?
    weak var parent: Coordinator?
    var children:[Coordinator]
    
    init(parent: Coordinator?) {
        children = []
        self.parent = parent
        self.navigationController = parent?.navigationController
        super.init()
        if let parent = parent {
            parent.addChild(coordinator: self)
        }
    }
    
    func start(fade: Bool = false, modal: Bool = false) {
        guard let viewController = viewController else { return }
        if modal {
            self.navigationController?.present(viewController, animated: true, completion: nil)
        } else {
            fade ?
                self.navigationController?.pushFade(to: viewController) :
                self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func addChild(coordinator: Coordinator) {
        children.append(coordinator)
    }
}
