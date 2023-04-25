//
//  TossPaymentsViewController+WKUIDelegate.swift
//
//
//  Created by https://github.com/MussaCharles on 2023/04/19.
//


import WebKit


// MARK: - WKUIDelegate

extension TossPaymentsViewController: WKUIDelegate, BrowserPopupHandler {
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        let popupWebView = createPopupWindow(parentWebView: webView,configuration: configuration)
        present(popupWebView: popupWebView)
        return popupWebView
        
    }
}
