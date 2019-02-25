
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import UIKit
import RxSwift

class AccountTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusTextLabel: UILabel!
    @IBOutlet weak var statusIconLabel: UILabel!
    @IBOutlet weak var statusContainer: UIView!
    
    func update(account: AccountViewModelItem) {
        titleLabel.text = account.title
        statusTextLabel.text = account.statusText
        statusIconLabel.text = account.statusIcon
        statusContainer.backgroundColor = account.statusColor
        
        self.accessoryType = .disclosureIndicator
    }
}
