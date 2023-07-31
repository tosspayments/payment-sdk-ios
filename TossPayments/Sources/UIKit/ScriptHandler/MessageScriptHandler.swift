//
//  MessageScriptHandler.swift
//  
//
//  Created by 김진규 on 2023/05/09.
//

import WebKit

final class MessageScriptHandler: NSObject, WKScriptMessageHandler {
    private weak var widget: PaymentWidget?
    init(_ widget: PaymentWidget) {
        self.widget = widget
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let body = message.body
        widget?.message(body)
    }
}
