//
//  결제정보.swift
//  
//
//  Created by 김진규 on 2022/09/27.
//

import Foundation

public protocol 결제정보: Codable {
    // 필수
    var amount: Int64 { get }
    var orderId: String { get }
    var orderName: String { get }
    
    // 필수
    var successUrl: String { get }
    var failUrl: String { get }

    // 선택
    var windowTarget: String { get }
    var customerName: String? { get }
    var customerEmail: String? { get }
    var taxFreeAmount: Int64? { get }
}

public extension 결제정보 {
    var jsonString: String? {
        guard let jsonObject = jsonObject,
              let data = try? JSONSerialization.data(withJSONObject: jsonObject) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    var orderedInfo: String {
        let orderdInfoKey = Set<String>([
            "amount", "orderId", "orderName", "windowTarget",
            "customerName", "customerEmail", "taxFreeAmount",
            "successUrl", "failUrl"
        ])
        let unorderedJsonObject = jsonObject?.filter({ !orderdInfoKey.contains($0.0) })
        let unorderedInfoString: String = unorderedJsonObject?.compactMap({ (key, value) in
            "\(key): \(value)"
        }).joined(separator: "\n") ?? ""
        return """
        amount: \(amount)
        orderId: \(orderId)
        orderName: \(orderName)
        windowTarget: \(windowTarget)
        customerName: \(customerName ?? "없음")
        customerEmail: \(customerEmail ?? "없음")
        taxFreeAmount: \(taxFreeAmount)
        successUrl: \(successUrl)
        failUrl: \(failUrl)\n
        """ + unorderedInfoString
    }
}

private extension 결제정보 {
    var jsonObject: [String: Any]? {
        return try? JSONSerialization.jsonObject(with: try! JSONEncoder().encode(self)) as? [String: Any]
    }
}
