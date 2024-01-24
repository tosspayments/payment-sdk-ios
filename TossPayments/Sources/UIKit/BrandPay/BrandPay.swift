//
//  File.swift
//  
//
//  Created by 김진규 on 2023/03/15.
//

import UIKit

extension PaymentWidget {

    /// 결제위젯에 추가적으로 들어갈 수 있는 기능
    public struct Options: Encodable {
        public let brandpay: BrandPay?
        let environment: Environment
        let service: String
        public init(
            brandpay: BrandPay?
        ) {
            self.brandpay = brandpay
            self.environment = Environment()
            self.service = "payment-widget-ios"
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

    public struct Environment: Encodable {
        public let platform: String = "ios"
        public let sdkVersion: String = "0.1.28"
        public let osVersion: String = UIDevice.current.systemVersion
    }
}
