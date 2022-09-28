//
//  EscrowProducts.swift
//  
//
//  Created by 김진규 on 2022/09/28.
//

import Foundation

public struct EscrowProducts: Codable {
    let id: String
    let name: String
    let code: String
    let unitPrice: Int64
    let quantity: Int64
}
