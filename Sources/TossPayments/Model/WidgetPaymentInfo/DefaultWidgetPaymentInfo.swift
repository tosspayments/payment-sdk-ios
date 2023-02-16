//
//  File.swift
//  
//
//  Created by 김진규 on 2023/02/16.
//

import Foundation

public struct DefaultWidgetPaymentInfo: WidgetPaymentInfo {
    
    // 필수
    public let orderId: String
    public let orderName: String
    
    // 선택
    public let customerName: String?
    public let customerEmail: String?
    public let taxFreeAmount: Double?
    public let cultureExpense: Bool
        
    public init(
        orderId: String,
        orderName: String,
        customerName: String? = nil,
        customerEmail: String? = nil,
        taxFreeAmount: Double? = nil,
        cultureExpense: Bool = false
    ) {
        self.orderId = orderId
        self.orderName = orderName
        self.customerName = customerName
        self.customerEmail = customerEmail
        self.taxFreeAmount = taxFreeAmount
        self.cultureExpense = cultureExpense
    }
}
