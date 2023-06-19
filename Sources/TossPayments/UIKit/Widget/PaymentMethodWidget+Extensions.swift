//
//  File.swift
//  
//
//  Created by 김진규 on 2023/06/19.
//

import Foundation

extension PaymentMethodWidget {
    
    public struct Amount: Encodable {
        public let value: Double
        public let currency: String?
        public let country: String?
        
        public init(
            value: Double,
            currency: String? = "KRW",
            country: String? = "KR"
        ) {
            self.value = value
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
