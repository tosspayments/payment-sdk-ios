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
    public let taxExemptionAmount: String?
    public let appScheme: String?
    
    // 선택
    public let customerName: String?
    public let customerEmail: String?
    public let taxFreeAmount: Double?
    public let cultureExpense: Bool
    
    // 추가 선택
    public let customerMobilePhone: String?
    public let showCustomerMobilePhone: String?
    public let useEscrow: Bool?
    public let escrowProducts: [String]?
    public let mobileCarrier: String?
    public let useInternationalCardOnly: Bool?
        
    public init(
        orderId: String,
        orderName: String,
        taxExemptionAmount: String? = nil,
        appScheme: String? = nil,
        customerName: String? = nil,
        customerEmail: String? = nil,
        taxFreeAmount: Double? = nil,
        cultureExpense: Bool = false,
        customerMobilePhone: String? = nil,
        showCustomerMobilePhone: String? = nil,
        useEscrow: Bool? = nil,
        escrowProducts: [String]? = nil,
        mobileCarrier: String? = nil,
        useInternationalCardOnly: Bool? = nil
    ) {
        self.orderId = orderId
        self.orderName = orderName
        self.taxExemptionAmount = taxExemptionAmount
        self.appScheme = appScheme
        self.customerName = customerName
        self.customerEmail = customerEmail
        self.taxFreeAmount = taxFreeAmount
        self.cultureExpense = cultureExpense
        self.customerMobilePhone = customerMobilePhone
        self.showCustomerMobilePhone = showCustomerMobilePhone
        self.useEscrow = useEscrow
        self.escrowProducts = escrowProducts
        self.mobileCarrier = mobileCarrier
        self.useInternationalCardOnly = useInternationalCardOnly
    }
}
