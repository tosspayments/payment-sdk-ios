//
//  가상계좌결제정보.swift
//  
//
//  Created by 김진규 on 2022/09/28.
//

import Foundation

public struct 가상계좌결제정보: 결제정보 {
    public let amount: Int64
    public let orderId: String
    public let orderName: String
    
    public let successUrl: String
    public let failUrl: String
    
    public let windowTarget: String

    public let validHours: Int64
    public let dueDate: String
    public let virtualAccountCallbackUrl: String
    public let customerMobilePhone: String
    public let showCustomerMobilePhone: Bool
    public let cashReceipt: CashReceipt
    public let useEscrow: Bool
    public let escrowProducts: EscrowProducts
    
    public let currency: String
    public let customerName: String?
    public let customerEmail: String?
    public let taxFreeAmount: Int64
    public let cultureExpense: Bool
}
