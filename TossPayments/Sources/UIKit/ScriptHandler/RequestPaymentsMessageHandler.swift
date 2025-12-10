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
        let service = WidgetService(htmlString: htmlString, baseURL: widget.baseURL, orderId: widget.orderId)
        let viewController = TossPaymentsViewController(service: service)
        service.successURLHandler = { url in
            viewController.dismiss(animated: true) {
                self.widget?.handleSuccessURL(url)
            }
        }
        service.failURLHandler = { url in
            guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                viewController.dismiss(animated: true) {
                    self.widget?.handleFailURL(url)
                }
                return
            }

            // NOTE(@JooYang): iOS 토스페이 웹에서 간혹 발생하는 code=102 에러(프레임 로드 중단됨)를 무시합니다.
            if components.query(for: "errorCode") == "102" {
                return
            }

            viewController.dismiss(animated: true) {
                self.widget?.handleFailURL(url)
            }
        }
        viewController.success = { javascript in
            viewController.dismiss(animated: true) {
                self.widget?.paymentMethodWidget?.evaluateJavaScript(javascript)
            }
        }
        viewController.error = { error in
            viewController.dismiss(animated: true) {
                self.widget?.delegate?.handleFailResult(error)
            }
        }
        
        UIApplication.shared.windows.first?.visibleViewController?.present(viewController, animated: true)
    }
}
