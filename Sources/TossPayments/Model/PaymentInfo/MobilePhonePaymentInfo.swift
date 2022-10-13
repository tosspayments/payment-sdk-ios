//
//  MobilePhonePaymentInfo.swift
//  
//
//  Created by 김진규 on 2022/09/28.
//

import Foundation

public struct MobilePhonePaymentInfo: PaymentInfo {
    public let amount: Int64
    public let orderId: String
    public let orderName: String
    
    public let successUrl: String
    public let failUrl: String
    
    public let windowTarget: String
    
    public let mobileCarrier: [CarrierCode]

    public let customerName: String?
    public let customerEmail: String?
    public let taxFreeAmount: Int64?
    
    public init(
        amount: Int64,
        orderId: String,
        orderName: String,
        successUrl: String,
        failUrl: String,
        windowTarget: String,
        mobileCarrier: [CarrierCode],
        customerName: String?,
        customerEmail: String?,
        taxFreeAmount: Int64
    ) {
        self.amount = amount
        self.orderId = orderId
        self.orderName = orderName
        self.successUrl = successUrl
        self.failUrl = failUrl
        self.windowTarget = windowTarget
        self.mobileCarrier = mobileCarrier
        self.customerName = customerName
        self.customerEmail = customerEmail
        self.taxFreeAmount = taxFreeAmount
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
