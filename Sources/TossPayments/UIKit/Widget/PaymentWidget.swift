//
//  PaymentWidget.swift
//  
//
//  Created by 김진규 on 2022/12/06.
//

import Foundation
import WebKit

enum ScriptName: String {
    case requestPayments
    case updateHeight
}

public final class PaymentWidget: WKWebView {
    public var amount: Int64 {
        didSet {
            
        }
    }
    let clientKey: String
    let customerKey: String
    
    weak var rootViewController: UIViewController?
    var info: PaymentInfo?
    
    var updatedHeight: CGFloat = 400 {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    public init(
        amount: Int64,
        clientKey: String,
        customerKey: String = "ANONYMOUS"
    ) {
        self.amount = amount
        self.clientKey = clientKey
        self.customerKey = customerKey
        let configuration = WKWebViewConfiguration()
        super.init(frame: .zero, configuration: configuration)
        configuration.userContentController.addUserScript(initializeWidgetScript)
        configuration.userContentController.add(RequestPaymentsMessageHandler(), name: ScriptName.requestPayments.rawValue)
        configuration.userContentController.add(UpdateHeightMessageHandler(), name: ScriptName.updateHeight.rawValue)

        loadHTMLString(htmlString, baseURL: URL(string: "https://tosspayments.com/"))
    }
    
    public override var intrinsicContentSize: CGSize {
        var size = UIScreen.main.bounds.size
        size.height = self.updatedHeight
        return size
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
        info: PaymentInfo,
        on rootViewController: UIViewController
    ) {
        self.info = info
        self.rootViewController = rootViewController
        let jsonString = info.requestJSONString ?? ""
        print(jsonString)
        let javascriptString = """
        widget.requestPaymentForNativeSDK(\(jsonString));
        """
        guard let encodedScript = javascriptString.urlEncoded.data(using: .utf8)?.base64EncodedString() else { return }
        evaluateJavaScript(
            """
            var script = decodeURIComponent(window.atob('\(encodedScript)'));
            console.log(script);
            eval(script);
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

final class RequestPaymentsMessageHandler: NSObject, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let htmlString = message.body as? String else { return }

        print(htmlString)
        let service = WidgetService(htmlString: htmlString)
        let viewController = TossPaymentsViewController(service: service)
        UIApplication.shared.keyWindow?.visibleViewController?.present(viewController, animated: true)
    }
}

final class UpdateHeightMessageHandler: NSObject, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let updatedHeight = message.body as? CGFloat else { return }
        (message.webView as? PaymentWidget)?.updatedHeight = updatedHeight
    }
}
