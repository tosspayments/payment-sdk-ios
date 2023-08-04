//
//  TossPaymentsDelegate.swift
//  
//
//  Created by 김진규 on 2022/09/27.
//

import Foundation

public protocol TossPaymentsDelegate: AnyObject {
    func handleSuccessResult(_ success: TossPaymentsResult.Success)
    func handleFailResult(_ fail: TossPaymentsResult.Fail)
}

protocol HandleURLResult {
    var delegate: TossPaymentsDelegate? { get }
    
    func handleSuccessURL(_ url: URL)
    func handleFailURL(_ url: URL)
}

extension HandleURLResult {
    func handleSuccessURL(_ url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
        let success = TossPaymentsResult.Success(
            paymentKey: components.query(for: "paymentKey"),
            orderId: components.query(for: "orderId"),
            amount: Double(components.query(for: "amount")) ?? 0,
            additionalParameters: (components.queryItems ?? [])
            .reduce(into: [String: String](), { partialResult, item in
                partialResult[item.name] = item.value
            })
        )
        delegate?.handleSuccessResult(success)
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
