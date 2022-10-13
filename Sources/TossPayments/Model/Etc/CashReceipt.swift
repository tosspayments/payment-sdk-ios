//
//  CashReceipt.swift
//  
//
//  Created by 김진규 on 2022/09/28.
//

import Foundation

public struct CashReceipt: Codable {
    public let type: String
    public init(
        type: String
    ) {
        self.type = type
    }
}
