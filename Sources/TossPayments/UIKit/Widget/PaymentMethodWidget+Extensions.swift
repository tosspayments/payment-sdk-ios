//
//  File.swift
//  
//
//  Created by 김진규 on 2023/06/19.
//

import Foundation

extension PaymentMethodWidget {
    public struct Options {
        public let variantKey: String?
        public init(
            variantKey: String?
        ) {
            self.variantKey = variantKey
        }
    }
}
