//
//  ViewController+Alert.swift
//  UIKitExample
//
//  Created by 김진규 on 2022/09/27.
//

#if canImport(UIKit)
import UIKit
import TossPayments

extension PaymentsViewController {
    func showAlertForInputCustomMethod() {
        let alertController = UIAlertController(
            title: "새로운 결제수단 테스트",
            message: "새로운 결제수단을 입력해주세요.",
            preferredStyle: .alert
        )
        alertController.addTextField()
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            if let title = alertController.textFields?.first?.text {
                self.입력한결제수단 = PaymentMethod(rawValue: title)
            }
        }))
        
        present(alertController, animated: true)
    }
    
    func showAlertEmpty결제수단() {
        let alertController = UIAlertController(
            title: "결제수단이 비어있습니다.",
            message: "결제수단을 입력해주세요.",
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "확인", style: .cancel))
        present(alertController, animated: true)
    }
}

#endif
