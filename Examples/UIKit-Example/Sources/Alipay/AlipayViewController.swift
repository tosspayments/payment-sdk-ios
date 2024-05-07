//
//  AlipayViewController.swift
//  UIKit-Example
//
//  Created by 윤지수 on 2024/05/06.
//  Copyright © 2024 TossPayments, Inc. All rights reserved.
//

#if canImport(UIKit)
import UIKit
import TossPayments

class AlipayViewController: ViewController {
    private lazy var 결제금액 = 100.0;
    private lazy var 클라이언트키화면: TextField = {
        let textField = TextField()
        textField.title = "Client Key"
        textField.text = Environment.clientKey
        textField.textField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        
        return textField
    }()
    private lazy var 금액금액화면: TextField = {
        let textField = TextField()
        textField.title = "금액(USD)"
        textField.text = "100"
        textField.textField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        
        return textField
    }()
    private lazy var 결제하기버튼 = Button()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.addArrangedSubview(클라이언트키화면)
        stackView.addArrangedSubview(금액금액화면)
        stackView.addArrangedSubview(결제하기버튼)
        
        결제하기버튼.title = "결제하기"
        
        결제하기버튼.addTarget(self, action: #selector(requestTossPayment), for: .touchUpInside)
    }
    
    @objc func textFieldDidChanged(_ sender: Any) {
        guard let superview = (sender as? UITextField)?.superview else { return }
        guard let text = (sender as? UITextField)?.text else { return }
        switch superview {
        case 클라이언트키화면:
            Environment.clientKey = text
        case 금액금액화면:
            결제금액 = Double(text) ?? 100.0
        default:
            break
        }
    }
    
    @objc func requestTossPayment() {
        let tossPayments = TossPayments(clientKey: Environment.clientKey)
        tossPayments.delegate = self
        let orderId = randomString(length: 10)
        print(orderId)
        tossPayments.requestPayment(PaymentMethod.해외간편결제, ForeignEasyPayPaymentInfo(
            amount: 결제금액,
            orderId: orderId,
            orderName: "토스 티셔츠 외 2건",
            provider: "ALIPAY",
            currency: "USD",
            country: "US",
            pendingUrl: "tosspaymentexample://pending",
            customerName: "박토스"
        ), on: self)
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }
}

extension AlipayViewController: TossPaymentsDelegate {
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
                handler: { _ in
                    UIPasteboard.general.string = message
                }
            )
        )
        alertController.addAction(UIAlertAction(title: "확인", style: .default))
        present(alertController, animated: true)
    }
}

#endif
