//
//  UpdateHeightMessageHandler.swift
//  
//
//  Created by 김진규 on 2023/03/15.
//

import WebKit

final class UpdateHeightMessageHandler: NSObject, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let updatedHeight = message.body as? CGFloat else { return }
        (message.webView as? CanUpdateHeight)?.updatedHeight = updatedHeight
    }
}
