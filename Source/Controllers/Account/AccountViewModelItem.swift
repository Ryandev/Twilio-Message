
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import UIKit

class AccountViewModelItem : ViewModel {
    var title: String?
    var statusText: String?
    var statusIcon: String?
    var statusColor: UIColor?

    var account: Account

    init(account: Account, subAccountIndex: Int) {
        if account.friendlyName?.hasPrefix("SubAccount") ?? false {
            title = "SubAccount #\(subAccountIndex)"
        } else {
            title = account.friendlyName?.replacingOccurrences(of: "'s Account", with: "")
        }
        statusText = account.status
        statusIcon = account.status == "active" ? "✓" : "❌"
        statusColor = account.status == "active" ? UIColor(hex: "3F9C00") : UIColor(hex: "#EA0005")
        
        self.account = account
        
        super.init()
    }
}
