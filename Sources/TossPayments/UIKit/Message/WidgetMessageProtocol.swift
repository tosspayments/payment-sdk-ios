//
//  WidgetMessageProtocol.swift
//  
//
//  Created by 김진규 on 2023/05/11.
//

import Foundation

protocol WidgetMessageProtocol: AnyObject {
    associatedtype Response = Codable
    var jsonObject: [String: Any] { get }
    var name: String? { get }
    var params: [String: Any]? { get }
    var response: Response? { get }
}

extension WidgetMessageProtocol where Response: Decodable {
    var name: String? {
        jsonObject["name"] as? String
    }
    
    var params: [String: Any]? {
        jsonObject["params"] as? [String: Any]
    }
    
    var response: Response? {
        guard let params, let data = try? JSONSerialization.data(withJSONObject: params) else { return nil }
        return try? JSONDecoder().decode(Response.self, from: data)
    }
}
