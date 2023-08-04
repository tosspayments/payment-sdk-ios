//
//  TossPaymentsViewController+WKUIDelegate.swift
//
//
//  Created by https://github.com/MussaCharles on 2023/04/19.
//

import WebKit

// MARK: - WKUIDelegate

extension TossPaymentsViewController: WKUIDelegate, BrowserPopupHandler {
    
    func webView(
        _ webView: WKWebView, 
        createWebViewWith configuration: WKWebViewConfiguration, 
        for navigationAction: WKNavigationAction, 
        windowFeatures: WKWindowFeatures
    ) -> WKWebView? {
        let popupWebView = createPopupWindow(parentWebView: webView, configuration: configuration)
        present(popupWebView: popupWebView)
        return popupWebView
    }
    
    func webView(
        _ webView: WKWebView,
        runJavaScriptConfirmPanelWithMessage message: String,
        initiatedByFrame frame: WKFrameInfo,
        completionHandler: @escaping (Bool) -> Void
    ) {
        /// 사파리 /.안드로이드 등에서 기본적인 alert의 title로 사용하는것을 차용
        let title: String? = {
            let domain: String? = {
                guard let url = webView.url else { return nil }
                guard let scheme = url.scheme else { return nil }
                guard let host = url.host else { return nil }
                
                return scheme + "://" + host
            }()
            
            guard let domain else { return nil }
            return """
            '\(domain)' 페이지 내용:
            """
        }()
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            completionHandler(true)
        }))
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { _ in
            completionHandler(false)
        }))
        UIApplication.shared.windows.first?.visibleViewController?.present(alertController, animated: true)
    }
    
    func webView(
        _ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String,
        initiatedByFrame frame: WKFrameInfo,
        completionHandler: @escaping () -> Void
    ) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "닫기", style: .default, handler: { _ in
            completionHandler()
        }))
        UIApplication.shared.windows.first?.visibleViewController?.present(alertController, animated: true)
    }
}
