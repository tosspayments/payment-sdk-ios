//
//  File.swift
//  
//
//  Created by 김진규 on 2023/03/15.
//

import Foundation

extension PaymentWidget {
    
    /// 결제위젯에 추가적으로 들어갈 수 있는 기능
    public struct Options: Encodable {
        public let brandPay: BrandPay?
        public init(
            brandPay: BrandPay?
        ) {
            self.brandPay = brandPay
        }
    }

    /// 브랜드페이
    public struct BrandPay: Encodable {
        
        /// 가맹점의 서버에서 구현해줘야하는 auth URL 주소
        public let redirectURL: String
        
        public init(redirectURL: String) {
            self.redirectURL = redirectURL
        }
    }
}
