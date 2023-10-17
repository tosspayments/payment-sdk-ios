//
//  TossPaymentsContentViewModel.swift
//  SwiftUI-Example
//
//  Created by 김진규 on 2023/08/04.
//  Copyright © 2023 TossPayments, Inc. All rights reserved.
//

import SwiftUI
import TossPayments

private enum Constants {
    static let clientKey: String = "test_ck_P24xLea5zVAqkMGkoG7VQAMYNwW6"
    static let 테스트결제정보: PaymentInfo = DefaultPaymentInfo(
        amount: 1000,
        orderId: "9lD0azJWxjBY0KOIumGzH",
        orderName: "토스 티셔츠 외 2건",
        customerName: "박토스"
    )
}

class TossPaymentsContentViewModel: ObservableObject {
    let widget = PaymentWidget(clientKey: Constants.clientKey, customerKey: "Test")


    @Published
    var isShowing: Bool = false
    
    @Published
    var onSuccess: TossPaymentsResult.Success?
    @Published
    var onFail: TossPaymentsResult.Fail?
    
    init() {
        widget.delegate = self
    }
    func requestPayment(info: WidgetPaymentInfo) {
        widget.requestPayment(
            info: DefaultWidgetPaymentInfo(orderId: "123", orderName: "김토스")
        )
    }
}
                              
extension TossPaymentsContentViewModel: TossPaymentsDelegate {
    func handleSuccessResult(_ success: TossPaymentsResult.Success) {
        onSuccess = success
    }
    
    func handleFailResult(_ fail: TossPaymentsResult.Fail) {
        onFail = fail
    }
}
