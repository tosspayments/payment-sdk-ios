//
//  PaymentWidget.swift
//  
//
//  Created by 김진규 on 2022/12/06.
//

import Foundation
import WebKit

public final class PaymentWidget: WKWebView {
    public var amount: Int64 {
        didSet {
            
        }
    }
    let clientKey: String
    let customerKey: String
    public init(
        amount: Int64 = 0,
        clientKey: String,
        customerKey: String = "ANONYMOUS"
    ) {
        self.amount = amount
        self.clientKey = clientKey
        self.customerKey = customerKey
        let configuration = WKWebViewConfiguration()
        super.init(frame: .zero, configuration: configuration)
        configuration.userContentController.addUserScript(initializeWidgetScript)
//        configuration.userContentController.add(<#T##scriptMessageHandler: WKScriptMessageHandler##WKScriptMessageHandler#>, name: <#T##String#>)
        
        loadHTMLString(htmlString, baseURL: URL(string: "https://tosspayments.com/"))
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var initializeWidgetScript = WKUserScript(
        source: """
                const widget = PaymentWidget("\(self.clientKey)", "\(self.customerKey)");
                const { updateAmount } = widget.renderPaymentMethods('#payment-method', \(amount));
                """,
        injectionTime: .atDocumentEnd,
        forMainFrameOnly: true
    )
    
    public func requestPayments(
        info: PaymentInfo
    ) {
        let infoString = info.requestJSONString ?? ""
        evaluateJavaScript(
            """
            widget.requestPaymentsForNativeSDK(\(infoString))
            """) { (_, error) in
                
            }
    }
    
    private var htmlString: String {
        """
        <!DOCTYPE html>
        <html>
        <head>
          <title>결제하기</title>
          <script src="https://js.tosspayments.com/beta/payment-widget"></script>
          <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        </head>
        <body>
            <div id="payment-method"></div>
        </body>
        </html>
        """
    }
}



