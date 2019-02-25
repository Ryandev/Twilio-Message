
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import UIKit
import StoreKit

enum BootArguments: String {
    case showWelcomeOnBoot = "ShowWelcomeOnBoot"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var coordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        _setupCoordinator(NavigationController())
        
        self.window?.rootViewController = coordinator?.navigationController
        
        self.window?.makeKeyAndVisible()
        
        UserDefaults.standard.bootCounter += 1

        _showReview()

        return true
    }
    
    fileprivate func _setupCoordinator(_ nav: UINavigationController) {
        let showWelcome = ( UserDefaults.standard.bootCounter <= 0 ) || _bootArguments.contains(BootArguments.showWelcomeOnBoot.rawValue)

        coordinator = showWelcome ?
            WelcomeCoordinator(parent: nil) :
            LoginCoordinator(parent: nil)
        
        coordinator?.navigationController = nav
        
        coordinator?.start()
    }
    
    fileprivate func _showReview() {
        guard UserDefaults.standard.bootCounter == 5 else { return }

        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        }
    }
    
    fileprivate var _bootArguments: [String] {
        return ProcessInfo.processInfo.arguments
    }
}

