//
//  File.swift
//  
//
//  Created by 김진규 on 2023/01/26.
//

import Foundation

public enum TossPaymentsResult {
    public struct Success: Equatable {
        
        /// 결제 식별자
        public let paymentKey: String
        
        /// 주문 식별자
        public let orderId: String
        
        /// 결제 금액
        public let amount: Double
        
        /// 추가 parameters
        public let additionalParameters: [String: String]?
    }
    
    public struct Fail: Equatable, Decodable {
        
        /// 결제 실패코드
        public let errorCode: String
        
        /// 결제 실패메세지
        public let errorMessage: String
        
        /// 주문 식별자
        public let orderId: String?
    }
}
