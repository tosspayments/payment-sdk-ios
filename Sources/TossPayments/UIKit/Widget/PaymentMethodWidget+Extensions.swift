//
//  File.swift
//  
//
//  Created by 김진규 on 2023/06/19.
//

import Foundation

extension PaymentMethodWidget {
    
    public struct Amount: Encodable {
        public let amount: Double
        public let currency: String?
        public let country: String?
        
        public init(
            amount: Double,
            currency: String? = nil,
            country: String? = nil
        ) {
            self.amount = amount
            self.currency = currency
            self.country = country
        }
    }
    
    public struct Options: Encodable {
        public let variantKey: String?
        public init(
            variantKey: String?
        ) {
            self.variantKey = variantKey
        }
    }
}
