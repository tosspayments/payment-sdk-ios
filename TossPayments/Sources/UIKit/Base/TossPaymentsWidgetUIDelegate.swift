//
//  WidgetUIDelegate.swift
//  
//
//  Created by 김진규 on 2023/01/16.
//

import Foundation
import CoreGraphics

public protocol TossPaymentsWidgetUIDelegate: AnyObject {
    func didUpdateHeight(_ widget: PaymentMethodWidget, height: CGFloat)
    func didReceivedCustomRequest(_ widget: PaymentMethodWidget, paymentMethodKey: String)
    func didReceivedCustomPaymentMethodSelected(_ widget: PaymentMethodWidget, paymentMethodKey: String)
    func didReceivedCustomPaymentMethodUnselected(_ widget: PaymentMethodWidget, paymentMethodKey: String)
}

public extension TossPaymentsWidgetUIDelegate {
    func didUpdateHeight(_ widget: PaymentMethodWidget, height: CGFloat) {}
    func didReceivedCustomRequest(_ widget: PaymentMethodWidget, paymentMethodKey: String) {}
    func didReceivedCustomPaymentMethodSelected(_ widget: PaymentMethodWidget, paymentMethodKey: String) {}
    func didReceivedCustomPaymentMethodUnselected(_ widget: PaymentMethodWidget, paymentMethodKey: String) {}
}

public protocol TossPaymentsAgreementUIDelegate: AnyObject {
    func didUpdateHeight(_ widget: AgreementWidget, height: CGFloat)
    func didUpdateAgreementStatus(_ widget: AgreementWidget, agreementStatus: AgreementStatus)
}

public extension TossPaymentsAgreementUIDelegate {
    func didUpdateHeight(_ widget: AgreementWidget, height: CGFloat) {}
    func didUpdateAgreementStatus(_ widget: AgreementWidget, agreementStatus: AgreementStatus) {}
}

public protocol TossPaymentsWidgetStatusDelegate: AnyObject {
    func didReceivedLoad(_ name: String)
    func didReceiveFail(_ name: String, fail: TossPaymentsResult.Fail)
}

public extension TossPaymentsWidgetStatusDelegate {
    func didReceivedLoad(_ name: String) {}
    func didReceiveFail(_ name: String, fail: TossPaymentsResult.Fail) {}
}
