//
//  RequestPaymentsMessageHandler.swift
//  
//
//  Created by 김진규 on 2023/03/15.
//

import UIKit
import WebKit

final class RequestPaymentsMessageHandler: NSObject, WKScriptMessageHandler {
    private weak var widget: PaymentWidget?
    init(_ widget: PaymentWidget) {
        self.widget = widget
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let htmlString = message.body as? String, let widget = widget else { return }
        let service = WidgetService(htmlString: htmlString, baseURL: widget.baseURL)
        let viewController = TossPaymentsViewController(service: service)
        service.successPaymentURLHandler = { url in
            viewController.dismiss(animated: true) {
                self.widget?.handlePaymentSuccessURL(url)
            }
        }
        service.successBrandPayURLHandler = { url in
            viewController.dismiss(animated: true) {
                self.widget?.handleBrandpaySuccessURL(url)
            }
        }
        service.failURLHandler = { url in
            viewController.dismiss(animated: true) {
                self.widget?.handleFailURL(url)
            }
        }
        viewController.success = { javascript in
            viewController.dismiss(animated: true) {
                self.widget?.evaluateJavaScript(javascript)
            }
        }
        UIApplication.shared.keyWindow?.visibleViewController?.present(viewController, animated: true)
    }
}

