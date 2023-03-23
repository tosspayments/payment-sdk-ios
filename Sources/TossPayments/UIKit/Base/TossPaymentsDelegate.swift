//
//  TossPaymentsDelegate.swift
//  
//
//  Created by 김진규 on 2022/09/27.
//

import Foundation

public protocol TossPaymentsDelegate: AnyObject {
    func handlePaymentSuccessResult(_ success: TossPaymentsResult.PaymentSuccess)
    func handleBrandPaySuccessResult(_ success: TossPaymentsResult.BrandPaySuccess)
    func handleFailResult(_ fail: TossPaymentsResult.Fail)
}

protocol HandleURLResult {
    var delegate: TossPaymentsDelegate? { get }
    
    func handlePaymentSuccessURL(_ url: URL)
    func handleBrandpaySuccessURL(_ url: URL)
    func handleFailURL(_ url: URL)
}

extension HandleURLResult {
    func handlePaymentSuccessURL(_ url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
        let success = TossPaymentsResult.PaymentSuccess(
            paymentKey: components.query(for: "paymentKey"),
            orderId: components.query(for: "orderId"),
            amount: Double(components.query(for: "amount")) ?? 0,
            additionalParameters: (components.queryItems ?? []).reduce(into: [String: String](), { partialResult, item in
                partialResult[item.name] = item.value
            })
        )
        delegate?.handlePaymentSuccessResult(success)
    }
    
    func handleBrandpaySuccessURL(_ url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
        let success = TossPaymentsResult.BrandPaySuccess(
            paymentKey: components.query(for: "paymentKey"),
            orderId: components.query(for: "orderId"),
            amount: Double(components.query(for: "amount")) ?? 0,
            methodId: components.query(for: "methodId")
        )
        delegate?.handleBrandPaySuccessResult(success)
    }
    
    func handleFailURL(_ url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
        let fail = TossPaymentsResult.Fail(
            errorCode: components.query(for: "code"),
            errorMessage: components.query(for: "message"),
            orderId: components.query(for: "orderId")
        )
        delegate?.handleFailResult(fail)
    }
}
