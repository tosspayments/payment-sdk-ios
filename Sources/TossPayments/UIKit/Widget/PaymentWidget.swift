//
//  PaymentWidget.swift
//  
//
//  Created by 김진규 on 2022/12/06.
//

import Foundation
import WebKit

public final class PaymentWidget: NSObject, HandleURLResult {
    private lazy var messageHandler = MessageHandler(
        paymentMethod: paymentMethodWidget,
        agreement: agreementWidget
    )
    private var amount: Double = 0 {
        didSet {
            guard amount != oldValue else { return }
            paymentMethodWidget.evaluateJavaScript("""
            updateAmount(\(amount))
            """)
        }
    }
    private var methodWidgetOptions: PaymentMethodWidget.Options?
    private var methodWidgetOptionsObject: String {
        guard let variantKey = methodWidgetOptions?.variantKey,
              !variantKey.isEmpty else { return "{}"}
        return """
            { variantKey: "\(variantKey)" }
            """
    }
        
    private let clientKey: String
    private let customerKey: String
    let options: Options?
    
    private weak var rootViewController: UIViewController?
    
    public weak var delegate: TossPaymentsDelegate?
    
    var baseURL: URL {
        guard let urlString = options?.brandPay?.redirectURL,
              let url = URL(string: urlString) else {
            return URL(string: "https://tosspayments.com")!
        }
        return url
    }
    
    public let paymentMethodWidget: PaymentMethodWidget
    public let agreementWidget: AgreementWidget
    public init(
        clientKey: String,
        customerKey: String,
        options: Options? = nil
    ) {
        self.clientKey = clientKey
        self.customerKey = customerKey
        self.options = options
        self.paymentMethodWidget = PaymentMethodWidget()
        self.agreementWidget = AgreementWidget()
        super.init()
    }
    
    public func renderPaymentMethods(
        amount: Double,
        options: PaymentMethodWidget.Options? = nil
    ) {
        self.amount = amount
        self.methodWidgetOptions = options
        paymentMethodWidget.configuration.userContentController.addUserScript(paymentMethodScript)
        paymentMethodWidget.configuration.userContentController.add(
            RequestPaymentsMessageHandler(self), 
            name: ScriptName.requestPayments.rawValue
        )
        paymentMethodWidget.configuration.userContentController.add(
            UpdateHeightMessageHandler(),
            name: ScriptName.updateHeight.rawValue
        )
        paymentMethodWidget.configuration.userContentController.add(
            RequestHTMLMessageHandler(self),
            name: ScriptName.requestHTML.rawValue
        )
        paymentMethodWidget.configuration.userContentController.add(
            MessageScriptHandler(self),
            name: ScriptName.message.rawValue
        )
        paymentMethodWidget.loadHTMLString(htmlString, baseURL: baseURL)
    }
    
    public func renderAgreement() {
        agreementWidget.configuration.userContentController.addUserScript(agreementScript)
        agreementWidget.configuration.userContentController.add(
            UpdateHeightMessageHandler(),
            name: ScriptName.updateHeight.rawValue
        )
        agreementWidget.configuration.userContentController.add(
            MessageScriptHandler(self),
            name: ScriptName.message.rawValue
        )
        agreementWidget.loadHTMLString(htmlString, baseURL: baseURL)
    }
    
    public func updateAmount(_ amount: Double) {
        self.amount = amount
    }
    
    func message(_ body: Any) {
        guard let jsonObject = body as? [String: Any] else { return }
        messageHandler.handle(jsonObject: jsonObject)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var paymentMethodSource: String = {
        if let redirectURLString = self.options?.brandPay?.redirectURL {
            return """
                const widget = PaymentWidget("\(self.clientKey)", "\(self.customerKey)", {
                  brandpay: { redirectUrl: "\(redirectURLString)" }
                });
                const { updateAmount } = widget.renderPaymentMethods('#payment-method', \(amount), \(methodWidgetOptionsObject));
                """
        } else {
            return """
                const widget = PaymentWidget("\(self.clientKey)", "\(self.customerKey)", {
                  brandpay: { redirectUrl: "" }
                });
                const { updateAmount } = widget.renderPaymentMethods('#payment-method', \(amount), \(methodWidgetOptionsObject));
                """
        }
    }()
    
    private lazy var agreementSource: String = {
        if let redirectURLString = self.options?.brandPay?.redirectURL {
            return """
                const widget = PaymentWidget("\(self.clientKey)", "\(self.customerKey)", {
                  brandpay: { redirectUrl: "\(redirectURLString)" }
                });
                widget.renderAgreement('#agreement');
                """
        } else {
            return """
                const widget = PaymentWidget("\(self.clientKey)", "\(self.customerKey)", {
                  brandpay: { redirectUrl: "" }
                });
                widget.renderAgreement('#agreement');
                """
        }
    }()
    private lazy var paymentMethodScript = WKUserScript(
        source: paymentMethodSource,
        injectionTime: .atDocumentEnd,
        forMainFrameOnly: true
    )
    private lazy var agreementScript = WKUserScript(
        source: agreementSource,
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
        paymentMethodWidget.evaluateJavaScript(
            """
            var script = decodeURIComponent(window.atob('\(encodedScript)'));
            eval(script);
            """) { (_, _) in
                    
            }
    }
    
    private var htmlString: String {
        """
        <!DOCTYPE html>
        <html>
        <head>
          <title>결제하기</title>
          <script src="https://js.tosspayments.com/\(TossPaymentsEnvironment.stage)/payment-widget"></script>
          <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        </head>
        <body style="margin:0;padding:0;overflow:hidden;">
            <div id="payment-method"></div>
            <div id="agreement"></div>
        </body>
        </html>
        """
    }
}
