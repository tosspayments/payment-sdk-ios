//
//  MobilePhonePaymentInfo.swift
//  
//
//  Created by 김진규 on 2022/09/28.
//

import Foundation

public struct MobilePhonePaymentInfo: PaymentInfo {
    public let amount: Double
    public let orderId: String
    public let orderName: String
    
    public let mobileCarrier: [CarrierCode]

    public let customerName: String?
    public let customerEmail: String?
    public let taxFreeAmount: Double?
    
    public init(
        amount: Double,
        orderId: String,
        orderName: String,
        mobileCarrier: [CarrierCode],
        customerName: String?,
        customerEmail: String?,
        taxFreeAmount: Double
    ) {
        self.amount = amount
        self.orderId = orderId
        self.orderName = orderName
        self.mobileCarrier = mobileCarrier
        self.customerName = customerName
        self.customerEmail = customerEmail
        self.taxFreeAmount = taxFreeAmount
    }
}
