
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation

extension URLRequest {
    static func getSMS(accSID: String, authKey: String) -> URLRequest {
        let urlExtension = URLRequest._apiExtensionSMS(accountSID: accSID)
        var req = URLRequest(url: URL.twilioAPI.appendingPathComponent(urlExtension))
        req.httpMethod = "GET"
        req.setHTTPBasicAuthHeader(username: accSID, password: authKey)
        return req
    }
    
    static func sendSMS(accSID: String, authKey: String, from: String, to: String, body: String?) -> URLRequest {
        let urlExtension = URLRequest._apiExtensionSMS(accountSID: accSID)
        var req = URLRequest(url: URL.twilioAPI.appendingPathComponent(urlExtension))
        req.httpMethod = "POST"
        req.setHTTPBasicAuthHeader(username: accSID, password: authKey)
        let bodyStr = "To=\(to)&From=\(from)&Body=\((body ?? ""))"
        req.httpBody = bodyStr.data(using: .utf8)
        return req
    }
    
    static func getAccounts(accSID: String, authKey: String) -> URLRequest {
        var req = URLRequest(url: URL.twilioAPI.appendingPathComponent(URLRequest._apiExtensionAccount))
        req.httpMethod = "GET"
        req.setHTTPBasicAuthHeader(username: accSID, password: authKey)
        return req
    }
    
    static func updateAccount(accSID: String, authKey: String, account: [AnyHashable:AnyObject]) -> URLRequest? {
        var urlComponents = URLComponents(string: URL.twilioAPI.appendingPathComponent(URLRequest._apiExtensionAccount).absoluteString)
        urlComponents?.query = account.queryString()
        guard let url = urlComponents?.url else { return nil; }
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        req.setHTTPBasicAuthHeader(username: accSID, password: authKey)
        req.httpBody = account.JSONData()
        return req
    }

    /* pragma mark - private */
    fileprivate static func _apiExtensionSMS(accountSID: String) -> String {
        return "Accounts/\(accountSID)/Messages.json"
    }

    fileprivate static let _apiExtensionAccount = "Accounts.json"
}
