//
//  WidgetPaymentInfo.swift
//  
//
//  Created by 김진규 on 2023/02/16.
//

import Foundation

public protocol WidgetPaymentInfo: Codable {
    // 필수
    var orderId: String { get }
    var orderName: String { get }
    
    // 선택
    var customerName: String? { get }
    var customerEmail: String? { get }
    var taxFreeAmount: Double? { get }
}

extension WidgetPaymentInfo {
    func convertToPaymentInfo(amount: Double) -> [String: Any]? {
        do {
            
            let data = try JSONEncoder().encode(self)
            var jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            jsonObject?["amount"] = amount
            return jsonObject
        } catch {
            fatalError()
        }
    }
}
