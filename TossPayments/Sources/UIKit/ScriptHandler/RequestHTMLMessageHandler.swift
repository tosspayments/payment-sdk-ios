//
//  RequestHTMLMessageHandler.swift
//  
//
//  Created by 김진규 on 2023/03/15.
//

import UIKit
import WebKit

final class RequestHTMLMessageHandler: NSObject, WKScriptMessageHandler {
    private weak var widget: PaymentWidget?
    init(_ widget: PaymentWidget) {
        self.widget = widget
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let htmlString = message.body as? String,
        let widget = widget else { return }
        let service = WidgetService(htmlString: htmlString, baseURL: widget.baseURL, orderId: widget.orderId)
        let viewController = TossPaymentsViewController(service: service)
        viewController.modalPresentationStyle = .fullScreen
        viewController.success = { javascript in
            viewController.dismiss(animated: true) {
                self.widget?.paymentMethodWidget?.evaluateJavaScript(javascript)
            }
        }
        UIApplication.shared.windows.first?.visibleViewController?.present(viewController, animated: true)
    }
}
