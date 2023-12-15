//
//  File.swift
//  
//
//  Created by 김진규 on 2023/06/19.
//

import Foundation

extension PaymentMethodWidget {
    
    @objc
    @objcMembers
    public class Amount: NSObject, Encodable {
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
    
    @objc(PaymentMethodWidgetOptions)
    @objcMembers
    public class Options: NSObject, Encodable {
        public let variantKey: String?
        public init(
            variantKey: String?
        ) {
            self.variantKey = variantKey
        }
    }
}
