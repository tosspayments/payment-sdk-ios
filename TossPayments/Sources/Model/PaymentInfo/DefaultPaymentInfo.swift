//
//  DefaultPaymentInfo.swift
//  
//
//  Created by 김진규 on 2022/09/28.
//

import Foundation

public struct DefaultPaymentInfo: PaymentInfo {
    
    // 필수
    public let amount: Double
    public let orderId: String
    public let orderName: String
    
    // 선택
    public let customerName: String?
    public let customerEmail: String?
    public let taxFreeAmount: Double?
    public let cultureExpense: Bool
        
    public init(
        amount: Double,
        orderId: String,
        orderName: String,
        customerName: String? = nil,
        customerEmail: String? = nil,
        taxFreeAmount: Double? = nil,
        cultureExpense: Bool = false
    ) {
        self.amount = amount
        self.orderId = orderId
        self.orderName = orderName
        self.customerName = customerName
        self.customerEmail = customerEmail
        self.taxFreeAmount = taxFreeAmount
        self.cultureExpense = cultureExpense
    }
}
