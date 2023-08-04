//
//  ErrorHandler.swift
//  
//
//  Created by 김진규 on 2023/07/17.
//

import WebKit

final class ErrorHandler: NSObject, WKScriptMessageHandler {
    private weak var viewController: TossPaymentsViewController?
    init(_ viewController: TossPaymentsViewController) {
        self.viewController = viewController
    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let jsonObject = message.body as? [String: Any] else { return }
        guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject) else { return }
        guard let error = try? JSONDecoder().decode(TossPaymentsResult.Fail.self, from: jsonData) else { return }
        
        viewController?.error?(error)
    }
}
