
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation

class ListMessageViewModelItem : ViewModel {
    var from: String?
    var to: String?
    var body: String?
    var date: String?
    
    convenience init(message: Message) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        let dateString = dateFormatter.string(from: message.dateSent ?? Date())
        
        self.init(from: message.from ?? "", to: message.to ?? "", body: message.body ?? "", date: dateString)
    }
    
    init(from: String, to: String, body: String, date: String) {
        self.from = from
        self.to = to
        self.body = body
        self.date = date
        super.init()
    }
}
