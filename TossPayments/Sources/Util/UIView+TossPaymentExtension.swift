//
//  UIView+TossPaymentExtension.swift
//  TossPayments
//
//  Created by 김진규 on 2024/01/24.
//  Copyright © 2024 TossPayments, Inc. All rights reserved.
//

import UIKit

extension UIView {
    var currentViewController: UIViewController? {
        var responder: UIResponder? = self
        while responder != nil {
            if let viewController = responder?.next as? UIViewController {
                return viewController
            }
            responder = responder?.next
        }
        
        return nil
    }
}
