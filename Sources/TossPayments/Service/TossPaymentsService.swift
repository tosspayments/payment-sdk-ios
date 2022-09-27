//
//  File.swift
//  
//
//  Created by 김진규 on 2022/09/27.
//

import Foundation
import WebKit

class TossPaymentsService: NSObject {
    private let clientKey: String
    private let 결제수단: 결제수단
    private let 결제정보: 결제정보
    init(
        clientKey: String,
        결제수단: 결제수단,
        결제정보: 결제정보
    ) {
        self.clientKey = clientKey
        self.결제수단 = 결제수단
        self.결제정보 = 결제정보
    }
    
    var failURLHandler: ((URL) -> Void)?
    var successURLHandler: ((URL) -> Void)?
    
    // 한번만 요청할 Javascript 요청 여부
    private var didEvaluateRequestPaymentsJavascript: Bool = false
}

extension TossPaymentsService {
    var htmlString: String {
        """
        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <script src="https://js.tosspayments.com/v1"></script>
        </head>

        <body>
        </body>

        </html>
        """
    }
    
    var requestPaymentsJavascript: String {
        return """
        var tossPayments = TossPayments('\(clientKey)');
        tossPayments.requestPayment('\(결제수단.rawValue)', \(결제정보.jsonString ?? ""));
        """
    }
    
    private func evaluateRequestPaymentsJavascript(with webView: WKWebView) {
        if didEvaluateRequestPaymentsJavascript { return }
        DispatchQueue.main.async {
            webView.evaluateJavaScript(self.requestPaymentsJavascript)
            self.didEvaluateRequestPaymentsJavascript = true
        }
    }
}

extension TossPaymentsService: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        //  FailURL 혹은 SuccessURL 처리
        if handleResult(with: navigationAction) {
            decisionHandler(.cancel)
            return
        }
        
        // https 이외의 action 처리
        if handleActionExceptHTTP(with: navigationAction) {
            decisionHandler(.cancel)
            return
        }
        
        decisionHandler(.allow)
    }
    
    func webView(
        _ webView: WKWebView,
        didFinish navigation: WKNavigation!
    ) {
        if webView.url?.absoluteString == "https://tosspayments.com/" {
            self.evaluateRequestPaymentsJavascript(with: webView)
        }
    }
}

extension TossPaymentsService {
    
    private func handleResult(with navigationAction: WKNavigationAction) -> Bool {
        guard let url = navigationAction.request.url else { return false }
        let urlString = url.absoluteString
        
        if urlString.hasPrefix(결제정보.failUrl) {
            failURLHandler?(url)
            return true
        } else if urlString.hasPrefix(결제정보.successUrl) {
            successURLHandler?(url)
            return true
        }
        
        return false
    }
    
    private func handleActionExceptHTTP(with navigationAction: WKNavigationAction) -> Bool {
        guard let url = navigationAction.request.url else { return false }
        guard !(url.scheme?.hasPrefix("http") ?? false) else { return false }
        guard url.scheme != "about" else { return false }
        UIApplication.shared.open(url)
        return true
    }
}
