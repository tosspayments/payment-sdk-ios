//
//  File.swift
//  
//
//  Created by 김진규 on 2022/09/27.
//

import Foundation

public struct 결제정보: Codable {
    
    // 필수
    public let amount: Int64
    public let orderId: String
    public let orderName: String
    
    // 선택
    public let windowTarget: String
    public let customerName: String?
    public let customerEmail: String?
    public let taxFreeAmount: Int64
    public let cultureExpense: Bool
    
    // 필수
    public let successUrl: String
    public let failUrl: String
    
    public let 추가정보: [String: String]
    
    public init(
        amount: Int64,
        orderId: String,
        orderName: String,
        windowTarget: String = "iframe",
        customerName: String? = nil,
        customerEmail: String? = nil,
        taxFreeAmount: Int64 = 0,
        cultureExpense: Bool = false,
        successUrl: String,
        failUrl: String,
        추가정보: [String: String] = [:]
    ) {
        self.amount = amount
        self.orderId = orderId
        self.orderName = orderName
        self.windowTarget = windowTarget
        self.customerName = customerName
        self.customerEmail = customerEmail
        self.taxFreeAmount = taxFreeAmount
        self.cultureExpense = cultureExpense
        self.successUrl = successUrl
        self.failUrl = failUrl
        self.추가정보 = 추가정보
    }
    
    public var orderedInfo: String {
        return """
        amount: \(amount)
        orderId: \(orderId)
        orderName: \(orderName)
        windowTarget: \(windowTarget)
        customerName: \(customerName ?? "없음")
        customerEmail: \(customerEmail ?? "없음")
        taxFreeAmount: \(taxFreeAmount)
        cultureExpense: \(cultureExpense)
        successUrl: \(successUrl)
        failUrl: \(failUrl)
        \((추가정보).map { "\($0): \($1)" }.joined(separator: "\n"))
        """
    }
    
    private var jsonObject: [String: Any]? {
        guard var jsonObject = try? JSONSerialization.jsonObject(with: try! JSONEncoder().encode(self)) as? [String: Any] else { return nil }
        guard let 추가정보 = jsonObject.removeValue(forKey: "추가정보") as? [String: Any] else { return nil }
        return jsonObject.merging(추가정보) { (_, _) in
            
        }
    }
    
    var jsonString: String? {
        guard let jsonObject = jsonObject,
              let data = try? JSONSerialization.data(withJSONObject: jsonObject) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
