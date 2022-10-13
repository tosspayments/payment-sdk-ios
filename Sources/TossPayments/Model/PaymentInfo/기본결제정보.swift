//
//  기본결제정보.swift
//  
//
//  Created by 김진규 on 2022/09/28.
//

import Foundation

public struct 기본결제정보: 결제정보 {
    
    // 필수
    public let amount: Int64
    public let orderId: String
    public let orderName: String
    
    // 필수
    public let successUrl: String
    public let failUrl: String

    // 선택
    public let windowTarget: String
    public let customerName: String?
    public let customerEmail: String?
    public let taxFreeAmount: Int64?
    public let cultureExpense: Bool
        
    public init(
        amount: Int64,
        orderId: String,
        orderName: String,
        successUrl: String,
        failUrl: String,
        windowTarget: String = "iframe",
        customerName: String? = nil,
        customerEmail: String? = nil,
        taxFreeAmount: Int64? = nil,
        cultureExpense: Bool = false
    ) {
        self.amount = amount
        self.orderId = orderId
        self.orderName = orderName
        self.successUrl = successUrl
        self.failUrl = failUrl
        self.windowTarget = windowTarget
        self.customerName = customerName
        self.customerEmail = customerEmail
        self.taxFreeAmount = taxFreeAmount
        self.cultureExpense = cultureExpense
    }
}
