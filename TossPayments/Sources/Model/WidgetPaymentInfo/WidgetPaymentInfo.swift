//
//  WidgetPaymentInfo.swift
//
//
//  Created by 김진규 on 2023/02/16.
//

import Foundation

@objc
public protocol WidgetPaymentInfo: AnyObject {
    // 필수
    var orderId: String { get }
    var orderName: String { get }
    
    // 선택
    var customerName: String? { get }
    var customerEmail: String? { get }
    var taxFreeAmount: NSNumber? { get }
}

extension WidgetPaymentInfo {
    func convertToPaymentInfo(amount: Double) -> [String: Any]? {
        let mirror = Mirror(reflecting: self)
        var infoDict: [String: Any] = [:]
        
        for case let (label?, value) in mirror.children {
            infoDict[label] = value
        }
        
        infoDict["amount"] = amount
        return infoDict
    }
}
