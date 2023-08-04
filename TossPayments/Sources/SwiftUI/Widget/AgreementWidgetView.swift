//
//  AgreementWidgetView.swift
//  TossPayments
//
//  Created by 김진규 on 2023/08/04.
//  Copyright © 2023 TossPayments, Inc. All rights reserved.
//

import SwiftUI

public struct AgreementWidgetView: UIViewRepresentable {
    public typealias UIViewType = AgreementWidget
    
    private let widget: PaymentWidget
    public init(
        widget: PaymentWidget
    ) {
        self.widget = widget
    }
    
    public func makeUIView(context: Context) -> AgreementWidget {
        widget.renderAgreement()
    }
    
    public func updateUIView(_ uiView: AgreementWidget, context: Context) {
        
    }
}
