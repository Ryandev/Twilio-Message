
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation
import UIKit
import WebKit
import RxSwift

class HelpViewController: ViewControllerBase {
    
    var viewModel: HelpViewModel?
    private let disposeBag = DisposeBag()
    
    private var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let conf = WKWebViewConfiguration()
        conf.dataDetectorTypes = WKDataDetectorTypes()
        webView = WKWebView(frame: self.view.bounds, configuration: conf)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        
        self.view.addSubview(webView)
        
        webView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        webView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1.0).isActive = true
        webView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0).isActive = true
        webView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0.0).isActive = true
        
        viewModel?.helpURL.asObservable()
            .subscribe({ [weak self] (event) in
                guard let self = self, let url = event.element else { return }
                self.webView.stopLoading()
                self.webView.loadFileURL(url, allowingReadAccessTo: url)
            })
            .disposed(by: disposeBag)
    }
}

extension HelpViewController: WKNavigationDelegate {
    /* if we need to open a file url, open locally otherwise open with Safari.app */
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let policy: WKNavigationActionPolicy = (navigationAction.request.url?.isFileURL ?? false) ? .allow : .cancel

        decisionHandler(policy)

        if policy == .cancel, let url = navigationAction.request.url {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

}

