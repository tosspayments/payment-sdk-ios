//
//  TossPaymentsDelegate.swift
//  
//
//  Created by 김진규 on 2022/09/27.
//

import Foundation

public protocol TossPaymentsDelegate: AnyObject {
    func didSucceedRequestPayments(paymentKey: String, orderId: String, amount: Int64)
    func didFailRequestPayments(errorCode: String, errorMessage: String, orderId: String)
}

protocol HandleURLResult {
    var delegate: TossPaymentsDelegate? { get }
    
    func handleSuccessURL(_ url: URL)
    func handleFailURL(_ url: URL)
}

extension HandleURLResult {
    func handleSuccessURL(_ url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
        let paymentKey = components.query(for: "paymentKey")
        let orderId = components.query(for: "orderId")
        let amount = Int64(components.query(for: "amount")) ?? 0
        delegate?.didSucceedRequestPayments(paymentKey: paymentKey, orderId: orderId, amount: amount)
    }
    
    func handleFailURL(_ url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
        let errorCode = components.query(for: "code")
        let errorMessage = components.query(for: "message")
        let orderId = components.query(for: "orderId")
        delegate?.didFailRequestPayments(errorCode: errorCode, errorMessage: errorMessage, orderId: orderId)
    }
}
