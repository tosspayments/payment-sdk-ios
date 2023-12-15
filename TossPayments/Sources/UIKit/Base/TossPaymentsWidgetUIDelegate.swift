//
//  WidgetUIDelegate.swift
//  
//
//  Created by 김진규 on 2023/01/16.
//

import Foundation
import CoreGraphics

@objc
public protocol TossPaymentsWidgetUIDelegate: AnyObject {
    
    @objc(didUpdateMethodWidgetHeight:height:)
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

@objc
public protocol TossPaymentsAgreementUIDelegate: AnyObject {
    
    @objc(didUpdateAgreementWidgetWidgetHeight:height:)
    func didUpdateHeight(_ widget: AgreementWidget, height: CGFloat)
    func didUpdateAgreementStatus(_ widget: AgreementWidget, agreementStatus: AgreementStatus)
}

public extension TossPaymentsAgreementUIDelegate {
    func didUpdateHeight(_ widget: AgreementWidget, height: CGFloat) {}
    func didUpdateAgreementStatus(_ widget: AgreementWidget, agreementStatus: AgreementStatus) {}
}

@objc
public protocol TossPaymentsWidgetStatusDelegate: AnyObject {
    func didReceivedLoad(_ name: String)
    func didReceiveFail(_ name: String, fail: TossPaymentsResult.Fail)
}

public extension TossPaymentsWidgetStatusDelegate {
    func didReceivedLoad(_ name: String) {}
    func didReceiveFail(_ name: String, fail: TossPaymentsResult.Fail) {}
}
