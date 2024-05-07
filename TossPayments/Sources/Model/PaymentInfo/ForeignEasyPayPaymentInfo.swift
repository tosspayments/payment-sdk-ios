//
//  ForeignEasyPay.swift
//
//  Created by 윤지수 on 2024/05/06.
//  Copyright © 2024 TossPayments, Inc. All rights reserved.
//

import Foundation

public struct ForeignEasyPayPaymentInfo: PaymentInfo {
    public var amount: Double
    public var orderId: String
    public var orderName: String
    
    public let provider: String
    public let currency: String
    public let country: String
    public let pendingUrl: String
    
    public var customerName: String?
    public var customerEmail: String?
    public var taxFreeAmount: Double?

    public init(
        amount: Double,
        orderId: String,
        orderName: String,
        provider: String,
        currency: String,
        country: String,
        pendingUrl: String,
        customerName: String? = nil,
        customerEmail: String? = nil,
        taxFreeAmount: Double? = nil
    ) {
        self.amount = amount
        self.orderId = orderId
        self.orderName = orderName
        self.provider = provider
        self.currency = currency
        self.country = country
        self.pendingUrl = pendingUrl
        self.customerName = customerName
        self.customerEmail = customerEmail
        self.taxFreeAmount = taxFreeAmount
    }
}
