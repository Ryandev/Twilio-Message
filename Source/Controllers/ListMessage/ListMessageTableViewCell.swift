
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import UIKit
import RxSwift

class ListMessageTableViewCell: UITableViewCell {
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var bodyContainer: UIView!

    private(set) var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func update(_ item: ListMessageViewModelItem) {
        fromLabel.text = item.from
        toLabel.text = item.to
        bodyLabel.text = item.body
        dateLabel.text = item.date
        
        bodyContainer.isHidden = ( item.body?.count ?? 0 ) == 0
    }
}
