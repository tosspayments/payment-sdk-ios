//
//  File.swift
//  
//
//  Created by 김진규 on 2023/02/16.
//

import Foundation

@objcMembers
public class DefaultWidgetPaymentInfo: NSObject, WidgetPaymentInfo {
    
    // 필수
    public let orderId: String
    public let orderName: String
    public let taxExemptionAmount: String?
    public let appScheme: String?
//    
//    // 선택
    public let customerName: String?
    public let customerEmail: String?
    public let taxFreeAmount: NSNumber?
    public let cultureExpense: Bool
//    
//    // 추가 선택
    public let customerMobilePhone: String?
    public let showCustomerMobilePhone: String?
    
    @nonobjc
    public private(set) var useEscrow: Bool?
    
    @objc(useEscrow)
    public private(set) var internalUseEscrow: NSNumber? {
        get {
            guard let useEscrow else { return nil }
            return useEscrow ? 1 : 0
        }
        set {
            guard let newValue else { return }
            useEscrow = newValue == 1
        }
    }
    
    public let escrowProducts: [String]?
    public let mobileCarrier: String?
        
    @nonobjc
    public init(
        orderId: String,
        orderName: String,
        taxExemptionAmount: String? = nil,
        appScheme: String? = nil,
        customerName: String? = nil,
        customerEmail: String? = nil,
        taxFreeAmount: NSNumber? = nil,
        cultureExpense: Bool = false,
        customerMobilePhone: String? = nil,
        showCustomerMobilePhone: String? = nil,
        useEscrow: Bool?,
        escrowProducts: [String]? = nil,
        mobileCarrier: String? = nil
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
    }
    
    public init(
        orderId: String,
        orderName: String,
        taxExemptionAmount: String? = nil,
        appScheme: String? = nil,
        customerName: String? = nil,
        customerEmail: String? = nil,
        taxFreeAmount: NSNumber? = nil,
        cultureExpense: Bool = false,
        customerMobilePhone: String? = nil,
        showCustomerMobilePhone: String? = nil,
        useEscrow: NSNumber? = nil,
        escrowProducts: [String]? = nil,
        mobileCarrier: String? = nil
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
        self.useEscrow = nil
        self.escrowProducts = escrowProducts
        self.mobileCarrier = mobileCarrier
    }
    
    public func convertToPaymentInfo() -> [String: Any]? {
        var info = [String: Any]()
        
        info["orderId"] = orderId
        info["orderName"] = orderName
        info["taxExemptionAmount"] = taxExemptionAmount
        info["appScheme"] = appScheme
        info["customerName"] = customerName
        info["customerEmail"] = customerEmail
        info["taxFreeAmount"] = taxFreeAmount
        info["cultureExpense"] = cultureExpense
        info["customerMobilePhone"] = customerMobilePhone
        info["showCustomerMobilePhone"] = showCustomerMobilePhone
        info["useEscrow"] = useEscrow
        info["escrowProducts"] = escrowProducts
        info["mobileCarrier"] = mobileCarrier
        
        return info
    }
}
