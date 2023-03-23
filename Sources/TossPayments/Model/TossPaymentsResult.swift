//
//  File.swift
//  
//
//  Created by 김진규 on 2023/01/26.
//

import Foundation

public enum TossPaymentsResult {
    public struct PaymentSuccess {
        
        /// 결제 식별자
        public let paymentKey: String
        
        /// 주문 식별자
        public let orderId: String
        
        /// 결제 금액
        public let amount: Double
        
        /// 추가 parameters
        public let additionalParameters: [String: String]?
    }
    
    public struct BrandPaySuccess {
        
        /// 결제 식별자
        public let paymentKey: String
        
        /// 주문 식별자
        public let orderId: String
        
        /// 결제 금액
        public let amount: Double
        
        /// 결제 ID
        public let methodId: String
    }
    
    public struct Fail {
        
        /// 결제 실패코드
        public let errorCode: String
        
        /// 결제 실패메세지
        public let errorMessage: String
        
        /// 주문 식별자
        public let orderId: String
    }
}
