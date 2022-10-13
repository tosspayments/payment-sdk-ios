//
//  ViewController+TossPaymentsDelegate.swift
//  UIKitExample
//
//  Created by 김진규 on 2022/09/27.
//

#if canImport(UIKit)
import Foundation
import TossPayments

extension ViewController: TossPaymentsDelegate {
    func didSucceedRequestPayments(paymentKey: String, orderId: String, amount: Int64) {
        print("didSucceedRequestPayments (paymentKey): \(paymentKey)")
        print("didSucceedRequestPayments (orderId): \(orderId)")
        print("didSucceedRequestPayments (amount): \(amount)")
    }
    
    func didFailRequestPayments(errorCode: String, errorMessage: String, orderId: String) {
        print("didFailRequestPayments (errorCode): \(errorCode)")
        print("didFailRequestPayments (errorMessage): \(errorMessage)")
        print("didFailRequestPayments (orderId): \(orderId)")
    }
}

#endif
