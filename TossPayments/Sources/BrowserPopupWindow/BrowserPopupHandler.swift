//
//  BrowserPopupHandler.swift
//
//
//  Created by https://github.com/MussaCharles on 2023/04/19.
//

import Foundation
import WebKit

/// Wraps logic to handle presenting `BrowserPopupWindowController`.
protocol BrowserPopupHandler {
    
    func createPopupWindow(parentWebView: WKWebView, configuration: WKWebViewConfiguration) -> WKWebView
    
    func present(popupWebView: WKWebView)
}

// MARK: - default Implementations

extension BrowserPopupHandler {
    
    func createPopupWindow(parentWebView: WKWebView, configuration: WKWebViewConfiguration) -> WKWebView {
        let popupWebView = WKWebView(frame: parentWebView.frame, configuration: configuration)
        popupWebView.navigationDelegate = parentWebView.navigationDelegate
        popupWebView.uiDelegate = parentWebView.uiDelegate
#if DEBUG
        if #available(iOS 16.4, *) {
            popupWebView.isInspectable = true
        }
#endif
        return popupWebView
    }
    
    func present(popupWebView: WKWebView) {
        guard let topViewController =  UIApplication.shared.windows
        .first(where: { $0.isKeyWindow })?.visibleViewController else { return }
        
        DispatchQueue.main.async {
            topViewController.present(
                UINavigationController(
                    rootViewController: BrowserPopupWindowController(
                        popupWebView: popupWebView
                    )
                ),
                animated: true
            )
        }
    }
    
}
