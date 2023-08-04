//
//  PaymentMethodWidget.swift
//  TossPayments
//
//  Created by 김진규 on 2023/08/04.
//  Copyright © 2023 TossPayments, Inc. All rights reserved.
//

import SwiftUI

public struct PaymentMethodWidgetView: UIViewRepresentable {
    public typealias UIViewType = PaymentMethodWidget
    
    private let widget: PaymentWidget
    private var amount: PaymentMethodWidget.Amount
    public init(
        widget: PaymentWidget,
        amount: PaymentMethodWidget.Amount
    ) {
        self.widget = widget
        self.amount = amount
    }
    
    public func makeUIView(context: Context) -> PaymentMethodWidget {
        widget.renderPaymentMethods(amount: amount)
    }
    
    public func updateUIView(_ uiView: PaymentMethodWidget, context: Context) {
        
    }
}
