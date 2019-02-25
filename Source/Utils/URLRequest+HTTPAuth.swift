
import Foundation

extension URLRequest {
    mutating func setHTTPBasicAuthHeader(username: String, password: String) {
        let usernamePassword = "\(username):\(password)"
        guard let usernamePasswordData = usernamePassword.data(using: .utf8) else { return; }

        let base64encodedAuth = usernamePasswordData.base64EncodedString()

        var httpHeaders = self.allHTTPHeaderFields

        httpHeaders?["Authorization"] = "Basic \(base64encodedAuth)"
        
        self.allHTTPHeaderFields = httpHeaders
    }
}
