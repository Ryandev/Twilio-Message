
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import RxSwift

enum APIError: Error, CustomStringConvertible, LocalizedError {
    case noInternetConnection
    case badDataInRequest
    case noDataInResponse
    case badDataInResponse
    
    var description: String {
        switch self {
        case .noInternetConnection:
            return "No internet connection"
            
        case .badDataInRequest:
            return "Bad data in request, cannot process"
            
        case .noDataInResponse:
            return "No response from Twilio API"
            
        case .badDataInResponse:
            return "Unable to load response from Twilio API"
        }
    }
    
    var localizedDescription: String {
        return self.description
    }
    
    var errorDescription: String? {
        return self.description
    }
}

class API {
    static let shared = API()
    
    fileprivate let reachability = Reachability()

    fileprivate let urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)

    func getMessages(accSID: String, authKey: String) -> Single<Messages> {
        return Single.create { [weak self] (observer) -> Disposable in
            if (self?.reachability?.hasConnection ?? false) == false {
                observer(.error(APIError.noInternetConnection));
                return Disposables.create()
            }
            
            let req = URLRequest.getSMS(accSID: accSID, authKey: authKey)
            let task = self?.urlSession.dataTask(with: req) { (data, response, error) in
                if let error = error {
                    observer(.error(error)); return
                }
                
                guard let data = data else {
                    observer(.error(APIError.noDataInResponse)); return
                }
                
                guard let json = data.JSON() else {
                    observer(.error(APIError.badDataInResponse)); return
                }
                
                if let twilioError = TwilioError.errorFromResponse(json) {
                    observer(.error(twilioError)); return
                }
                
                let messages = Messages()
                messages.update(dictionary: json)
                observer(.success(messages))

            }
            
            task?.resume()
            
            let disposable = Disposables.create {
                task?.cancel()
            }
            
            return disposable
        }
    }
    
    func sendMessage(from account: Account, message: Message) -> Single<Message> {
        return Single.create { [weak self] (observer) -> Disposable in
            if (self?.reachability?.hasConnection ?? false) == false {
                observer(.error(APIError.noInternetConnection));
                return Disposables.create()
            }
            
            let req = URLRequest.sendSMS(accSID: account.sid ?? "",
                                         authKey: account.authToken ?? "",
                                         from: message.from ?? "",
                                         to: message.to ?? "",
                                         body: message.body ?? "")
            let task = self?.urlSession.dataTask(with: req) { (data, response, error) in
                if let error = error {
                    observer(.error(error)); return
                }
                
                guard let data = data else {
                    observer(.error(APIError.noDataInResponse)); return
                }
                
                guard let json = data.JSON() else {
                    observer(.error(APIError.badDataInResponse)); return
                }
                
                if let twilioError = TwilioError.errorFromResponse(json) {
                    observer(.error(twilioError)); return
                }
                
                let message = Message()
                message.update(dictionary: json)
                observer(.success(message))
            }
            
            task?.resume()
            
            let disposable = Disposables.create {
                task?.cancel()
            }
            
            return disposable
        }
    }
    
    func getAccounts(accSID: String, authKey: String) -> Single<Accounts> {
        return Single.create { [weak self] (observer) -> Disposable in
            if (self?.reachability?.hasConnection ?? false) == false {
                observer(.error(APIError.noInternetConnection));
                return Disposables.create()
            }
            
            let req = URLRequest.getAccounts(accSID: accSID, authKey: authKey)
            let task = self?.urlSession.dataTask(with: req) { (data, response, error) in
                if let error = error {
                    observer(.error(error)); return
                }
                
                guard let data = data else {
                    observer(.error(APIError.noDataInResponse)); return
                }
                
                guard let json = data.JSON() else {
                    observer(.error(APIError.badDataInResponse)); return
                }
                
                if let twilioError = TwilioError.errorFromResponse(json) {
                    observer(.error(twilioError)); return
                }

                let accounts = Accounts()
                accounts.update(dictionary: json)
                observer(.success(accounts))
            }
            
            task?.resume()
            
            let disposable = Disposables.create {
                task?.cancel()
            }
            
            return disposable
        }
    }

    func updateAccount(account: Account) -> Single<Account> {
        return Single.create { [weak self] (observer) -> Disposable in
            if (self?.reachability?.hasConnection ?? false) == false {
                observer(.error(APIError.noInternetConnection));
                return Disposables.create()
            }
            
            let req = URLRequest.updateAccount(accSID: account.sid ?? "",
                                               authKey: account.authToken ?? "",
                                               account: account.serialize())
            
            var task: URLSessionDataTask? = nil
            
            let disposable = Disposables.create {
                task?.cancel()
            }

            guard let request = req else {
                observer(.error(APIError.badDataInRequest))
                return disposable
            }
            
            task = self?.urlSession.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    observer(.error(error)); return
                }
                
                guard let data = data else {
                    observer(.error(APIError.noDataInResponse)); return
                }
                
                guard let json = data.JSON() else {
                    observer(.error(APIError.badDataInResponse)); return
                }
                
                if let twilioError = TwilioError.errorFromResponse(json) {
                    observer(.error(twilioError)); return
                }

                let account = Account()
                account.update(dictionary: json)
                observer(.success(account))
            }
                
            task?.resume()
            
            return disposable
        }
    }
}
