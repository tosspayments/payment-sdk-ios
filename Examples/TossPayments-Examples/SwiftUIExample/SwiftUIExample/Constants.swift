//
//  Constants.swift
//  SwiftUIExample
//
//  Created by 김진규 on 2022/09/27.
//

import Foundation
import TossPayments

enum Constants {
    static let clientKey: String = "test_ck_P24xLea5zVAqkMGkoG7VQAMYNwW6"
    static let 테스트결제정보: 결제정보 = 결제정보(
        amount: 1000,
        orderId: "9lD0azJWxjBY0KOIumGzH",
        orderName: "토스 티셔츠 외 2건",
        customerName: "박토스",
        successUrl: "http://localhost:8080/success",
        failUrl: "http://localhost:8080/fail",
        추가정보: [
            "additioanlInfo": "testAdditionalInfo"
        ]
    )
}
