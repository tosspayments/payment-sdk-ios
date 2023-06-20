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
    
    // swiftlint:disable:next cyclomatic_complexity
    func handle(jsonObject: [String: Any]) {
        switch jsonObject["name"] as? String {
        case "updateAgreementStatus":
            paymentMethod?.evaluateJavaScript("""
        widget.updateAgreementStatus(\(jsonObject))
        """)
            guard let agreement = agreement else { return }
            guard let agreementStatus = UpdateAgreementStatusMessage(jsonObject: jsonObject).response
            else { return }
            agreement.agreementUIDelegate?.didUpdateAgreementStatus(agreement, agreementStatus: agreementStatus)
        case "customRequest":
            guard let paymentMethod = paymentMethod else { return }
            guard let customRequest = CustomRequestMessage(jsonObject: jsonObject).response else { return }
            paymentMethod.widgetUIDelegate?.didReceivedCustomRequest(
                paymentMethod,
                paymentMethodKey: customRequest.paymentMethodKey
            )
        case "customPaymentMethodSelect":
            guard let paymentMethod = paymentMethod else { return }
            guard let customRequest = CustomPaymentMethodSelectedMessage(jsonObject: jsonObject).response
            else { return }
            paymentMethod.widgetUIDelegate?.didReceivedCustomPaymentMethodSelected(
                paymentMethod,
                paymentMethodKey: customRequest.paymentMethodKey
            )
        case "customPaymentMethodUnselect":
            guard let paymentMethod = paymentMethod else { return }
            guard let customRequest = CustomPaymentMethodUnselectedMessage(jsonObject: jsonObject).response
            else { return }
            paymentMethod.widgetUIDelegate?.didReceivedCustomPaymentMethodUnselected(
                paymentMethod,
                paymentMethodKey: customRequest.paymentMethodKey
            )
        case "widgetStatus":
            guard let widgetStatus = WidgetStatusMessage(jsonObject: jsonObject).response else { return }
            if let paymentMethod, widgetStatus.widget == "paymentMethods" {
                paymentMethod.widgetUIDelegate?.didReceivedWidgetStatus(paymentMethod, status: widgetStatus.status)
            } else if let agreement, widgetStatus.widget == "agreement" {
                agreement.agreementUIDelegate?.didReceivedWidgetStatus(agreement, status: widgetStatus.status)
            }
                    
        default:
            break
        }
        
    }
}
