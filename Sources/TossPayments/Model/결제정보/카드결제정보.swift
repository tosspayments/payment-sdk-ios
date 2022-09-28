//
//  카드결제정보.swift
//  
//
//  Created by 김진규 on 2022/09/28.
//

import Foundation

public struct 카드결제정보: 결제정보 {
    public let amount: Int64
    public let orderId: String
    public let orderName: String
    
    public let successUrl: String
    public let failUrl: String
    
    public let windowTarget: String
    
    public let cardCompany: String
    public let cardInstallmentPlan: Int64
    public let maxCardInstallmentPlan: Int64
    public let freeInstallmentPlans: [Plan]
    public let useCardPoint: Bool
    public let useAppCardOnly: Bool
    public let useInternationalCardOnly: Bool
    public let flowMode: String
    public let easyPay: String
    public let discountCode: String
    public let appScheme: String
    
    public let customerName: String?
    public let customerEmail: String?
    public let taxFreeAmount: Int64
    
    public struct Plan: Codable {
        public let company: String
        public let months: [Int]

    }
}
