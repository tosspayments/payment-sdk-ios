//
//  WidgetUIDelegate.swift
//  
//
//  Created by 김진규 on 2023/01/16.
//

import CoreGraphics

public protocol TossPaymentsWidgetUIDelegate: AnyObject {
    func didUpdateHeight(_ widget: PaymentWidget, height: CGFloat)
}
