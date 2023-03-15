//
//  SuccessHandler.swift
//  
//
//  Created by 김진규 on 2023/03/15.
//

import WebKit

final class SuccessHandler: NSObject, WKScriptMessageHandler {
    private weak var viewController: TossPaymentsViewController?
    init(_ viewController: TossPaymentsViewController) {
        self.viewController = viewController
    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let javascript = message.body as? String else { return }
        viewController?.success?(javascript)
    }
}
