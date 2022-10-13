//
//  CardPaymentInfo.swift
//  
//
//  Created by 김진규 on 2022/09/28.
//

import Foundation

public struct CardPaymentInfo: 결제정보 {
    public let amount: Int64
    public let orderId: String
    public let orderName: String
    
    public let successUrl: String
    public let failUrl: String
    
    public let windowTarget: String
    
    public let cardCompany: String?
    public let cardInstallmentPlan: Int64?
    public let maxCardInstallmentPlan: Int64?
    public let freeInstallmentPlans: [Plan]?
    public let useCardPoint: Bool?
    public let useAppCardOnly: Bool?
    public let useInternationalCardOnly: Bool?
    public let flowMode: String
    public let easyPay: String?
    public let discountCode: String?
    public let appScheme: String?
    
    public let customerName: String?
    public let customerEmail: String?
    public let taxFreeAmount: Int64?
    
    public struct Plan: Codable {
        public let company: String
        public let months: [Int]
        
        public init(
            company: String,
            months: [Int]
        ) {
            self.company = company
            self.months = months
        }
    }
    
    public init(
        amount: Int64,
        orderId: String,
        orderName: String,
        successUrl: String,
        failUrl: String,
        windowTarget: String = "iframe",
        cardCompany: String? = nil,
        cardInstallmentPlan: Int64? = nil,
        maxCardInstallmentPlan: Int64? = nil,
        freeInstallmentPlans: [Plan]? = nil,
        useCardPoint: Bool? = nil,
        useAppCardOnly: Bool? = nil,
        useInternationalCardOnly: Bool? = nil,
        flowMode: String = "DEFAULT",
        easyPay: String? = nil,
        discountCode: String? = nil,
        appScheme: String? = nil,
        customerName: String? = nil,
        customerEmail: String? = nil,
        taxFreeAmount: Int64? = nil
    ) {
        self.amount = amount
        self.orderId = orderId
        self.orderName = orderName
        self.successUrl = successUrl
        self.failUrl = failUrl
        self.windowTarget = windowTarget
        self.cardCompany = cardCompany
        self.cardInstallmentPlan = cardInstallmentPlan
        self.maxCardInstallmentPlan = maxCardInstallmentPlan
        self.freeInstallmentPlans = freeInstallmentPlans
        self.useCardPoint = useCardPoint
        self.useAppCardOnly = useAppCardOnly
        self.useInternationalCardOnly = useInternationalCardOnly
        self.flowMode = flowMode
        self.easyPay = easyPay
        self.discountCode = discountCode
        self.appScheme = appScheme
        self.customerName = customerName
        self.customerEmail = customerEmail
        self.taxFreeAmount = taxFreeAmount
    }
}
