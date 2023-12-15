//
//  File.swift
//  
//
//  Created by 김진규 on 2023/01/26.
//

import Foundation

public enum TossPaymentsResult {
    @objc
    public class Success: NSObject {
        
        /// 결제 식별자
        public let paymentKey: String
        
        /// 주문 식별자
        public let orderId: String
        
        /// 결제 금액
        public let amount: Double
        
        /// 추가 parameters
        public let additionalParameters: [String: String]?
        
        @objc
        public init(
            paymentKey: String,
            orderId: String,
            amount: Double,
            additionalParameters: [String : String]?
        ) {
            self.paymentKey = paymentKey
            self.orderId = orderId
            self.amount = amount
            self.additionalParameters = additionalParameters
        }
        
        public override func isEqual(_ object: Any?) -> Bool {
            guard let fail = object as? Success else { return false }
            return self.paymentKey == fail.paymentKey
            && self.orderId == fail.orderId
            && self.amount == fail.amount
            && self.additionalParameters == fail.additionalParameters
        }
    }
    
    @objc
    public class Fail: NSObject, Decodable {
        
        /// 결제 실패코드
        public let errorCode: String
        
        /// 결제 실패메세지
        public let errorMessage: String
        
        /// 주문 식별자
        public let orderId: String?
        
        @objc
        public init(errorCode: String, errorMessage: String, orderId: String?) {
            self.errorCode = errorCode
            self.errorMessage = errorMessage
            self.orderId = orderId
        }
        
        public override func isEqual(_ object: Any?) -> Bool {
            guard let fail = object as? Fail else { return false }
            return self.errorCode == fail.errorCode
            && self.errorMessage == fail.errorMessage
            && self.orderId == fail.orderId
        }
    }
}
