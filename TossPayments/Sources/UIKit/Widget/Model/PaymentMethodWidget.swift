//
//  PaymentMethodWidget.swift
//  
//
//  Created by 김진규 on 2023/05/09.
//

import Foundation
import WebKit

public final class PaymentMethodWidget: WKWebView, PaymentWidgetComponent {
    public weak var widgetStatusDelegate: TossPaymentsWidgetStatusDelegate?
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
#if DEBUG
        if #available(iOS 16.4, *) {
            isInspectable = true
        }
#endif
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public override var intrinsicContentSize: CGSize {
        var size = UIScreen.main.bounds.size
        size.height = self.updatedHeight
        return size
    }
    
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
