//
//  GiftCertificatePaymentInfo.swift
//  
//
//  Created by 김진규 on 2022/09/28.
//

import Foundation

public struct GiftCertificatePaymentInfo: PaymentInfo {
    public let amount: Double
    public let orderId: String
    public let orderName: String
    
    public let customerName: String?
    public let customerEmail: String?
    public let taxFreeAmount: Double?
    public let subOrders: [SubOrder]?
    
    public init(
        amount: Double,
        orderId: String,
        orderName: String,
        customerName: String?,
        customerEmail: String?,
        taxFreeAmount: Double?,
        subOrders: [SubOrder]? = nil
    ) {
        self.amount = amount
        self.orderId = orderId
        self.orderName = orderName
        self.customerName = customerName
        self.customerEmail = customerEmail
        self.taxFreeAmount = taxFreeAmount
        self.subOrders = subOrders
    }
}
