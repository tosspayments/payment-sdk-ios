//
//  PaymentMethodWidget.swift
//  
//
//  Created by 김진규 on 2023/05/09.
//

import Foundation
import WebKit

public final class PaymentMethodWidget: WKWebView, CanUpdateHeight {
    public weak var widgetUIDelegate: TossPaymentsWidgetUIDelegate?
    
    public var updatedHeight: CGFloat = 400 {
        didSet {
            guard oldValue != updatedHeight else { return }
            widgetUIDelegate?.didUpdateHeight(self, height: updatedHeight)
            invalidateIntrinsicContentSize()
        }
    }
    
    init() {
        super.init(frame: .zero, configuration: WKWebViewConfiguration())
        uiDelegate = self
        navigationDelegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public override var intrinsicContentSize: CGSize {
        var size = UIScreen.main.bounds.size
        size.height = self.updatedHeight
        return size
    }
    
}

// MARK: - WKNavigationDelegate
extension PaymentMethodWidget: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print(navigationAction.request)
        decisionHandler(.allow)
    }
    
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error)
    }
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error)
    }
    
}

// MARK: - WKUIDelegate

extension PaymentMethodWidget: WKUIDelegate, BrowserPopupHandler {
    
    public func webView(
        _ webView: WKWebView,
        createWebViewWith configuration: WKWebViewConfiguration,
        for navigationAction: WKNavigationAction,
        windowFeatures: WKWindowFeatures
    ) -> WKWebView? {
        let popupWebView = createPopupWindow(parentWebView: webView, configuration: configuration)
        present(popupWebView: popupWebView)
        return popupWebView
        
    }
}
