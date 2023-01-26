//
//  VirtualAccountPaymentInfo.swift
//  
//
//  Created by 김진규 on 2022/09/28.
//

import Foundation

public struct VirtualAccountPaymentInfo: PaymentInfo {
    public let amount: Double
    public let orderId: String
    public let orderName: String

    public let validHours: Int64
    public let dueDate: String
    public let customerMobilePhone: String
    public let showCustomerMobilePhone: Bool
    public let cashReceipt: CashReceipt
    public let useEscrow: Bool
    public let escrowProducts: EscrowProducts
    
    public let currency: String
    public let customerName: String?
    public let customerEmail: String?
    public let taxFreeAmount: Double?
    public let cultureExpense: Bool
    
    public init(
        amount: Double,
        orderId: String,
        orderName: String,
        validHours: Int64,
        dueDate: String,
        customerMobilePhone: String,
        showCustomerMobilePhone: Bool,
        cashReceipt: CashReceipt,
        useEscrow: Bool,
        escrowProducts: EscrowProducts,
        currency: String,
        customerName: String?,
        customerEmail: String?,
        taxFreeAmount: Double,
        cultureExpense: Bool
    ) {
        self.amount = amount
        self.orderId = orderId
        self.orderName = orderName
        self.validHours = validHours
        self.dueDate = dueDate
        self.customerMobilePhone = customerMobilePhone
        self.showCustomerMobilePhone = showCustomerMobilePhone
        self.cashReceipt = cashReceipt
        self.useEscrow = useEscrow
        self.escrowProducts = escrowProducts
        self.currency = currency
        self.customerName = customerName
        self.customerEmail = customerEmail
        self.taxFreeAmount = taxFreeAmount
        self.cultureExpense = cultureExpense
    }
}
