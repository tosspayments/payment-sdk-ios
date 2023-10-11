//
//  ChangePaymentMethodMessage.swift
//  TossPayments
//
//  Created by 김진규 on 2023/09/25.
//  Copyright © 2023 TossPayments, Inc. All rights reserved.
//

import Foundation

final class ChangePaymentMethodMessage: WidgetMessageProtocol {
    typealias Response = WidgetPaymentMethod
    let jsonObject: [String : Any]
    init(jsonObject: [String : Any]) {
        self.jsonObject = jsonObject
    }
}
