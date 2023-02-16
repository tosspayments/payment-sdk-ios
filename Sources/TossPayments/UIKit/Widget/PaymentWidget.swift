//
//  PaymentWidget.swift
//  
//
//  Created by 김진규 on 2022/12/06.
//

import Foundation
import WebKit

private enum ScriptName: String {
    case requestPayments
    case updateHeight
}

public final class PaymentWidget: WKWebView, HandleURLResult {
    private var amount: Double = 0 {
        didSet {
            guard amount != oldValue else { return }
            evaluateJavaScript("""
            updateAmount(\(amount))
            """)
        }
    }
    private let clientKey: String
    private let customerKey: String
    
    private weak var rootViewController: UIViewController?
    
    public weak var delegate: TossPaymentsDelegate?
    public weak var widgetUIDelegate: TossPaymentsWidgetUIDelegate?
    
    var updatedHeight: CGFloat = 400 {
        didSet {
            guard oldValue != updatedHeight else { return }
            widgetUIDelegate?.didUpdateHeight(self, height: updatedHeight)
            invalidateIntrinsicContentSize()
        }
    }
    
    public init(
        clientKey: String,
        customerKey: String
    ) {
        self.clientKey = clientKey
        self.customerKey = customerKey
        let configuration = WKWebViewConfiguration()
        super.init(frame: .zero, configuration: configuration)
    }
    
    public func renderPaymentMethods(amount: Double) {
        self.amount = amount
        configuration.userContentController.addUserScript(initializeWidgetScript)
        configuration.userContentController.add(RequestPaymentsMessageHandler(self), name: ScriptName.requestPayments.rawValue)
        configuration.userContentController.add(UpdateHeightMessageHandler(), name: ScriptName.updateHeight.rawValue)

        loadHTMLString(htmlString, baseURL: URL(string: "https://tosspayments.com/"))
    }
    
    public func updateAmount(_ amount: Double) {
        self.amount = amount
    }
    
    public override var intrinsicContentSize: CGSize {
        var size = UIScreen.main.bounds.size
        size.height = self.updatedHeight
        return size
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var initializeWidgetScript = WKUserScript(
        source: """
                const widget = PaymentWidget("\(self.clientKey)", "\(self.customerKey)");
                const { updateAmount } = widget.renderPaymentMethods('#payment-method', \(amount));
                """,
        injectionTime: .atDocumentEnd,
        forMainFrameOnly: true
    )
    
    public func requestPayment(
        info: WidgetPaymentInfo,
        on rootViewController: UIViewController
    ) {
        var requestJSONObject = info.convertToPaymentInfo(amount: amount)
        requestJSONObject?["successUrl"] = WebConstants.successURL
        requestJSONObject?["failUrl"] = WebConstants.failURL
        let jsonString = requestJSONObject?.jsonString ?? ""
        
        self.rootViewController = rootViewController
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
          <script src="https://js.tosspayments.com/v1/payment-widget"></script>
          <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        </head>
        <body style="margin:0;padding:0;overflow:hidden;">
            <div id="payment-method"></div>
        </body>
        </html>
        """
    }
}

private final class RequestPaymentsMessageHandler: NSObject, WKScriptMessageHandler {
    private weak var widget: PaymentWidget?
    init(_ widget: PaymentWidget) {
        self.widget = widget
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let htmlString = message.body as? String else { return }
        let service = WidgetService(htmlString: htmlString)
        let viewController = TossPaymentsViewController(service: service)
        service.successURLHandler = { url in
            viewController.dismiss(animated: true) {
                self.widget?.handleSuccessURL(url)
            }
        }
        service.failURLHandler = { url in
            viewController.dismiss(animated: true) {
                self.widget?.handleFailURL(url)
            }
        }
        UIApplication.shared.keyWindow?.visibleViewController?.present(viewController, animated: true)
    }
}

private final class UpdateHeightMessageHandler: NSObject, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let updatedHeight = message.body as? CGFloat else { return }
        (message.webView as? PaymentWidget)?.updatedHeight = updatedHeight
    }
}
