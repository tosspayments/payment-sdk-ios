//
//  PaymentWidget.swift
//  
//
//  Created by 김진규 on 2022/12/06.
//

import Foundation
import WebKit

public final class PaymentWidget: NSObject, HandleURLResult {
    // MARK: - Private properties
    private lazy var messageHandler = MessageHandler(
        paymentMethod: paymentMethodWidget,
        agreement: agreementWidget
    )

    @available(*, deprecated, message: "use paymentMethodScript")
    private lazy var legacyPaymentMethodScript = WKUserScript(
        source: legacyPaymentMethodSource,
        injectionTime: .atDocumentEnd,
        forMainFrameOnly: true
    )
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
    
    // MARK: Internal properties
    var amount: Double = 0 {
        didSet {
            guard amount != oldValue else { return }
            paymentMethodWidget?.evaluateJavaScript("""
            updateAmount(\(amount))
            """)
        }
    }
    private var methodWidgetAmount: PaymentMethodWidget.Amount?
    var methodWidgetAmountObjectString: String {
        guard let jsonString = methodWidgetAmount.jsonString else { return "\(amount)"}
        return jsonString
    }
    
    private var methodWidgetOptions: PaymentMethodWidget.Options?
    var methodWidgetOptionsObject: String {
        guard let jsonString = methodWidgetOptions?.jsonString else { return "{}"}
        return jsonString
    }
        
    let clientKey: String
    let customerKey: String
    private let options: Options?
    var optionsObject: String {
        guard let jsonString = options?.jsonString else { return "{}"}
        return jsonString
    }
    var baseURL: URL {
        guard let urlString = options?.brandPay?.redirectURL,
              let url = URL(string: urlString) else {
            return URL(string: "https://tosspayments.com")!
        }
        return url
    }
    
    // MARK: Public properties
    public var delegate: TossPaymentsDelegate?
    public var paymentMethodWidget: PaymentMethodWidget?
    public var agreementWidget: AgreementWidget?
    public init(
        clientKey: String,
        customerKey: String,
        options: Options? = nil
    ) {
        self.clientKey = clientKey
        self.customerKey = customerKey
        self.options = options
        
        super.init()
    }
    
    // MARK: Internal methods
    func message(_ body: Any) {
        guard let jsonObject = body as? [String: Any] else { return }
        messageHandler.handle(jsonObject: jsonObject)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public methods
    public func renderPaymentMethods(amount: PaymentMethodWidget.Amount, options: PaymentMethodWidget.Options? = nil) -> PaymentMethodWidget {
        let paymentMethodWidget = PaymentMethodWidget()
        self.methodWidgetAmount = amount
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
        
        self.paymentMethodWidget = paymentMethodWidget
        return paymentMethodWidget
    }
    
    @available(*, deprecated, message: "use func renderPaymentMethods(amount: PaymentMethodWidget.Object, options: PaymentMethodWidget.Options? = nil)")
    public func renderPaymentMethods(
        amount: Double,
        options: PaymentMethodWidget.Options? = nil
    ) -> PaymentMethodWidget {
        let paymentMethodWidget = PaymentMethodWidget()
        self.amount = amount
        self.methodWidgetOptions = options
        
        paymentMethodWidget.configuration.userContentController.addUserScript(legacyPaymentMethodScript)
        
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
        
        self.paymentMethodWidget = paymentMethodWidget
        return paymentMethodWidget
    }
    
    public func renderAgreement() -> AgreementWidget {
        let agreementWidget = AgreementWidget()
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
        self.agreementWidget = agreementWidget
        return agreementWidget
    }
    
    public func updateAmount(_ amount: Double) {
        self.amount = amount
    }
    
    public func requestPayment(
        info: WidgetPaymentInfo
    ) {
        var requestJSONObject = info.convertToPaymentInfo(amount: amount)
        requestJSONObject?["successUrl"] = WebConstants.successURL
        requestJSONObject?["failUrl"] = WebConstants.failURL
        let jsonString = requestJSONObject?.jsonString ?? ""
        
        let javascriptString = """
        widget.requestPaymentForNativeSDK(\(jsonString));
        """
        guard let encodedScript = javascriptString.urlEncoded.data(using: .utf8)?.base64EncodedString() else { return }
        paymentMethodWidget?.evaluateJavaScript(
            """
            var script = decodeURIComponent(window.atob('\(encodedScript)'));
            eval(script);
            """) { (_, _) in
                    
            }
    }
}
