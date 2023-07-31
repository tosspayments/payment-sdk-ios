//
//  PaymentInfo.swift
//  
//
//  Created by 김진규 on 2022/09/27.
//

import Foundation

public protocol PaymentInfo: Codable {
    // 필수
    var amount: Double { get }
    var orderId: String { get }
    var orderName: String { get }
    
    // 선택
    var customerName: String? { get }
    var customerEmail: String? { get }
    var taxFreeAmount: Double? { get }
}

public extension PaymentInfo {
    var orderedInfo: String {
        let orderdInfoKey = Set<String>([
            "amount", "orderId", "orderName",
            "customerName", "customerEmail", "taxFreeAmount"
        ])
        let unorderedJsonObject = self.jsonObject?.filter({ !orderdInfoKey.contains($0.0) })
        let unorderedInfoString: String = unorderedJsonObject?.compactMap({ (key, value) in
            "\(key): \(value)"
        }).joined(separator: "\n") ?? ""
        return """
        amount: \(amount)
        orderId: \(orderId)
        orderName: \(orderName)
        customerName: \(customerName ?? "없음")
        customerEmail: \(customerEmail ?? "없음")
        taxFreeAmount: \(taxFreeAmount ?? 0)\n
        """ + unorderedInfoString
    }
}

extension PaymentInfo {
    static func requestJSONString(
        jsonObject: [String: Any]?
    ) -> String? {
        var requestJSONObject = jsonObject
        requestJSONObject?["successUrl"] = WebConstants.successURL
        requestJSONObject?["failUrl"] = WebConstants.failURL
        return requestJSONObject?.jsonString
    }
    
    // 필수 값을 넣어준다.
    var requestJSONObject: [String: Any]? {
        var requestJSONObject = self.jsonObject
        requestJSONObject?["successUrl"] = WebConstants.successURL
        requestJSONObject?["failUrl"] = WebConstants.failURL
        return requestJSONObject
    }
    
    var requestJSONString: String? {
        let result = requestJSONObject?.jsonString
        return result
    }
}

extension Encodable {
    var jsonObject: [String: Any]? {
        guard let object = try? JSONEncoder().encode(self) else { return nil }
        return try? JSONSerialization.jsonObject(with: object) as? [String: Any]
    }
    
    var jsonString: String? {
        guard let jsonObject = jsonObject,
              let jsonString = jsonObject.jsonString else { return nil }
        return jsonString
    }
}

extension Dictionary where Key == String, Value == Any {
    var jsonString: String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
