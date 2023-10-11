//
//  WidgetPaymentMethod.swift
//  TossPayments
//
//  Created by 김진규 on 2023/09/19.
//  Copyright © 2023 TossPayments, Inc. All rights reserved.
//

import Foundation

public struct WidgetPaymentMethod: Codable {
    
    /// 결제 타입 정보입니다. NORMAL(일반결제), BRANDPAY(브랜드페이), KEYIN(키인 결제), CUSTOM(커스텀 결제수단) 중 하나입니다.
    public let type: PaymentMethodType
    
    /// 결제수단입니다. 카드, 가상계좌, 간편결제, 휴대폰, 계좌이체, 문화상품권, 도서문화상품권, 게임문화상품권 중 하나입니다.
    public let method: PaymentMethod?
    
    /// 결제수단이 간편결제일 때 반환되는 간편결제 정보입니다.
    public let easyPay: EasyPay?
    
    /// 결제 타입이 CUSTOM일 때 반환되는 커스텀 결제수단 키입니다.
    public let paymentMethodKey: String?
    
    /// 결제수단이 가상계좌일 때 반환되는 가상계좌 정보입니다.
    public let transfer: Transfer?
    
    public enum PaymentMethodType: RawRepresentable, Codable {
        case normal
        case brandpay
        case keyin
        case custom
        case unknown(type: String)
        
        public init?(rawValue: String) {
            switch rawValue {
            case "NORMAL": self = .normal
            case "BRANDPAY": self = .brandpay
            case "KEYIN": self = .keyin
            case "CUSTOM": self = .custom
            default: self = .unknown(type: rawValue)
            }
        }
        
        public var rawValue: String {
            switch self {
            case .normal: return "NORMAL"
            case .brandpay: return "BRANDPAY"
            case .keyin: return "KEYIN"
            case .custom: return "CUSTOM"
            case let .unknown(type: type): return type
         }
        }
    }
    
    public struct EasyPay: Codable {
        /// 선택한 간편결제사 코드입니다.
        public let provider: String
    }

    public struct Transfer: Codable {
        /// 선택한 계좌 코드입니다.
        public let provider: String
    }
}
