//
//  File.swift
//  
//
//  Created by 김진규 on 2023/06/19.
//

import Foundation

extension PaymentWidget {
    var htmlString: String {
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
    
    @available(*, deprecated, message: "use paymentMethodSource")
    var legacyPaymentMethodSource: String {
        return """
                const widget = PaymentWidget("\(self.clientKey)", "\(self.customerKey)", \(optionsObject));
                const { updateAmount } = widget.renderPaymentMethods('#payment-method', \(amount), \(methodWidgetOptionsObject));
                """
    }
    
    var paymentMethodSource: String {
        return """
                const widget = PaymentWidget("\(self.clientKey)", "\(self.customerKey)", \(optionsObject));
                const paymentMethodWidget = widget.renderPaymentMethods('#payment-method', \(methodWidgetAmountObjectString), \(methodWidgetOptionsObject));
                const { updateAmount } = paymentMethodWidget;
                """
    }
    
    var agreementSource: String {
        return """
                const widget = PaymentWidget("\(self.clientKey)", "\(self.customerKey)", \(optionsObject));
                widget.renderAgreement('#agreement');
                """
        
    }
}
