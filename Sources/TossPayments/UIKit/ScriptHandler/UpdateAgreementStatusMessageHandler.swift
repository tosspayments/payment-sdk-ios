//
//  UpdateAgreementStatus.swift
//  
//
//  Created by 김진규 on 2023/05/09.
//

import WebKit

final class UpdateAgreementStatusMessageHandler: NSObject, WKScriptMessageHandler {
    private weak var widget: PaymentWidget?
    init(_ widget: PaymentWidget) {
        self.widget = widget
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let isAgree = message.body as? Bool else { return }
        widget?.updateAgreementStatus(isAgree)
    }
}
