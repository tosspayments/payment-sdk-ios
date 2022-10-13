//
//  TossPaymentsDelegate.swift
//  
//
//  Created by 김진규 on 2022/09/27.
//

import Foundation

public protocol TossPaymentsDelegate {
    func didSucceedRequestPayments(paymentKey: String, orderId: String, amount: Int64)
    func didFailRequestPayments(errorCode: String, errorMessage: String, orderId: String)
}
