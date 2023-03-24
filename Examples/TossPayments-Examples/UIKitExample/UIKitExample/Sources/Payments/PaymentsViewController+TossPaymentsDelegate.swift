//
//  ViewController+TossPaymentsDelegate.swift
//  UIKitExample
//
//  Created by 김진규 on 2022/09/27.
//

#if canImport(UIKit)
import Foundation
import TossPayments
import UIKit

extension PaymentsViewController: TossPaymentsDelegate {
    func handleSuccessResult(_ success: TossPaymentsResult.Success) {
        let title = "TossPayments 요청에 성공하였습니다."
        let message = """
        didSucceedRequestPayment
        paymentKey: \(success.paymentKey)
        orderId: \(success.orderId)
        amount: \(success.amount)
        """
        showAlert(title: title, message: message)
    }
    
    func handleFailResult(_ fail: TossPaymentsResult.Fail) {
        let title = "TossPayments 요청에 실패하였습니다."
        let message = """
        didFailRequestPayment
        errorCode: \(fail.errorCode)
        errorMessage: \(fail.errorMessage)
        orderId: \(fail.orderId)
        """
        showAlert(title: title, message: message)
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        alertController.addAction(
            UIAlertAction(
                title: "클립보드에 복사하기",
                style: .destructive,
                handler: { action in
                    UIPasteboard.general.string = message
                }
            )
        )
        alertController.addAction(UIAlertAction(title: "확인", style: .default))
        present(alertController, animated: true)
    }
}

#endif
