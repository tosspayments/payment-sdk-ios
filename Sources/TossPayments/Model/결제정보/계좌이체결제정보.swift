//
//  계좌이체결제정보.swift
//  
//
//  Created by 김진규 on 2022/09/28.
//

import Foundation

public struct 계좌이체결제정보: 결제정보 {
    public let amount: Int64
    public let orderId: String
    public let orderName: String
    
    public let successUrl: String
    public let failUrl: String
    
    public let windowTarget: String

    public let cashReceipt: CashReceipt
    public let useEscrow: Bool
    public let escrowProducts: EscrowProducts

    public let customerName: String?
    public let customerEmail: String?
    public let taxFreeAmount: Int64
    public let cultureExpense: Bool
    
    public init(
        amount: Int64,
        orderId: String,
        orderName: String,
        successUrl: String,
        failUrl: String,
        windowTarget: String,
        cashReceipt: CashReceipt,
        useEscrow: Bool,
        escrowProducts: EscrowProducts,
        customerName: String?,
        customerEmail: String?,
        taxFreeAmount: Int64,
        cultureExpense: Bool
    ) {
        self.amount = amount
        self.orderId = orderId
        self.orderName = orderName
        self.successUrl = successUrl
        self.failUrl = failUrl
        self.windowTarget = windowTarget
        self.cashReceipt = cashReceipt
        self.useEscrow = useEscrow
        self.escrowProducts = escrowProducts
        self.customerName = customerName
        self.customerEmail = customerEmail
        self.taxFreeAmount = taxFreeAmount
        self.cultureExpense = cultureExpense
    }
}
