//
//  EscrowProducts.swift
//  
//
//  Created by 김진규 on 2022/09/28.
//

import Foundation

public struct EscrowProducts: Codable {
    public let id: String
    public let name: String
    public let code: String
    public let unitPrice: Int64
    public let quantity: Int64
    
    public init(
        id: String,
        name: String,
        code: String,
        unitPrice: Int64,
        quantity: Int64
    ) {
        self.id = id
        self.name = name
        self.code = code
        self.unitPrice = unitPrice
        self.quantity = quantity
    }
}
