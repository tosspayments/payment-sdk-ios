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
        public let brandpay: BrandPay?
        public init(
            brandpay: BrandPay?
        ) {
            self.brandpay = brandpay
        }
    }

    /// 브랜드페이
    public struct BrandPay: Encodable {
        
        /// 가맹점의 서버에서 구현해줘야하는 auth URL 주소
        public let redirectURL: String
        enum CodingKeys: String, CodingKey {
            case redirectURL = "redirectUrl"
        }
        
        public init(redirectURL: String) {
            self.redirectURL = redirectURL
        }
    }
}
