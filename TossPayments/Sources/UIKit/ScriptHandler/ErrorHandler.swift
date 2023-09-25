//
//  ErrorHandler.swift
//  
//
//  Created by 김진규 on 2023/07/17.
//

import WebKit

final class ErrorHandler: NSObject, WKScriptMessageHandler {
    var error: ((TossPaymentsResult.Fail) -> Void)?
    init(_ error: ((TossPaymentsResult.Fail) -> Void)?) {
        self.error = error
    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let jsonObject = message.body as? [String: Any] else { return }
        guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject) else { return }
        guard let fail = try? JSONDecoder().decode(TossPaymentsResult.Fail.self, from: jsonData) else { return }
        
        error?(fail)
    }
}
