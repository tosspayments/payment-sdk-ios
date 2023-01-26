//
//  TransferPaymentInfo.swift
//  
//
//  Created by 김진규 on 2022/09/28.
//

import Foundation

public struct TransferPaymentInfo: PaymentInfo {
    public let amount: Double
    public let orderId: String
    public let orderName: String

    public let cashReceipt: CashReceipt?
    public let useEscrow: Bool?
    public let escrowProducts: EscrowProducts?

    public let customerName: String?
    public let customerEmail: String?
    public let taxFreeAmount: Double?
    public let cultureExpense: Bool?
    
    public init(
        amount: Double,
        orderId: String,
        orderName: String,
        cashReceipt: CashReceipt? = nil,
        useEscrow: Bool? = nil,
        escrowProducts: EscrowProducts? = nil,
        customerName: String? = nil,
        customerEmail: String? = nil,
        taxFreeAmount: Double? = nil,
        cultureExpense: Bool? = nil
    ) {
        self.amount = amount
        self.orderId = orderId
        self.orderName = orderName
        self.cashReceipt = cashReceipt
        self.useEscrow = useEscrow
        self.escrowProducts = escrowProducts
        self.customerName = customerName
        self.customerEmail = customerEmail
        self.taxFreeAmount = taxFreeAmount
        self.cultureExpense = cultureExpense
    }
}
