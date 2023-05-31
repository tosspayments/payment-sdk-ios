//
//  MessageHandler.swift
//  
//
//  Created by 김진규 on 2023/05/11.
//

import Foundation

final class MessageHandler {
    private weak var paymentMethod: PaymentMethodWidget?
    private weak var agreement: AgreementWidget?
    
    init(
        paymentMethod: PaymentMethodWidget?,
        agreement: AgreementWidget?
    ) {
        self.paymentMethod = paymentMethod
        self.agreement = agreement
    }
    
    func handle(jsonObject: [String: Any]) {
        switch jsonObject["name"] as? String {
        case "updateAgreementStatus":
            paymentMethod?.evaluateJavaScript("""
        widget.updateAgreementStatus(\(jsonObject))
        """)
            guard let agreement = agreement else { return }
            guard let agreementStatus = UpdateAgreementStatusMessage(jsonObject: jsonObject).response else { return }
            agreement.agreementUIDelegate?.didUpdateAgreementStatus(agreement, agreementStatus: agreementStatus)
        case "customRequest":
            guard let paymentMethod = paymentMethod else { return }
            guard let customRequest = CustomRequestMessage(jsonObject: jsonObject).response else { return }
            paymentMethod.widgetUIDelegate?.didReceivedCustomRequest(
                paymentMethod,
                paymentMethodKey: customRequest.paymentMethodKey
            )
        case "customPaymentMethodSelectedMessage":
            guard let paymentMethod = paymentMethod else { return }
            guard let customRequest = CustomPaymentMethodSelectedMessage(jsonObject: jsonObject).response else { return }
            paymentMethod.widgetUIDelegate?.didReceivedCustomPaymentMethodSelected(
                paymentMethod,
                paymentMethodKey: customRequest.paymentMethodKey
            )
        case "customPaymentMethodUnselectedMessage":
            guard let paymentMethod = paymentMethod else { return }
            guard let customRequest = CustomPaymentMethodUnselectedMessage(jsonObject: jsonObject).response else { return }
            paymentMethod.widgetUIDelegate?.didReceivedCustomPaymentMethodUnselected(
                paymentMethod,
                paymentMethodKey: customRequest.paymentMethodKey
            )
        default:
            break
        }
        
    }
}
