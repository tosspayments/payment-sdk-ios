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
    private lazy var ALIPAY_버튼 = Button()
    private lazy var ALIPAYHK_버튼 = Button()
    private lazy var BILLEASE_버튼 = Button()
    private lazy var BOOST_버튼 = Button()
    private lazy var BPI_버튼 = Button()
    private lazy var DANA_버튼 = Button()
    private lazy var GCASH_버튼 = Button()
    private lazy var RABBIT_LINE_PAY_버튼 = Button()
    private lazy var TOUCHNGO_버튼 = Button()
    private lazy var TRUEMONEY_버튼 = Button()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.addArrangedSubview(클라이언트키화면)
        stackView.addArrangedSubview(금액금액화면)
        
        stackView.addArrangedSubview(ALIPAY_버튼)
        stackView.addArrangedSubview(ALIPAYHK_버튼)
        stackView.addArrangedSubview(BILLEASE_버튼)
        stackView.addArrangedSubview(BOOST_버튼)
        stackView.addArrangedSubview(BPI_버튼)
        stackView.addArrangedSubview(DANA_버튼)
        stackView.addArrangedSubview(GCASH_버튼)
        stackView.addArrangedSubview(RABBIT_LINE_PAY_버튼)
        stackView.addArrangedSubview(TOUCHNGO_버튼)
        stackView.addArrangedSubview(TRUEMONEY_버튼)
        
        ALIPAY_버튼.title = "ALIPAY 결제하기"
        ALIPAYHK_버튼.title = "ALIPAYHK 결제하기"
        BILLEASE_버튼.title = "BILLEASE 결제하기"
        BOOST_버튼.title = "BOOST 결제하기"
        BPI_버튼.title = "BPI 결제하기"
        DANA_버튼.title = "DANA 결제하기"
        GCASH_버튼.title = "GCASH 결제하기"
        RABBIT_LINE_PAY_버튼.title = "RABBIT_LINE_PAY 결제하기"
        TOUCHNGO_버튼.title = "TOUCHNGO 결제하기"
        TRUEMONEY_버튼.title = "TRUEMONEY 결제하기"
        
        ALIPAY_버튼.addTarget(self, action: #selector(ALIPAY_실행), for: .touchUpInside)
        ALIPAYHK_버튼.addTarget(self, action: #selector(ALIPAYHK_실행), for: .touchUpInside)
        BILLEASE_버튼.addTarget(self, action: #selector(BILLEASE_실행), for: .touchUpInside)
        BOOST_버튼.addTarget(self, action: #selector(BOOST_실행), for: .touchUpInside)
        BPI_버튼.addTarget(self, action: #selector(BPI_실행), for: .touchUpInside)
        DANA_버튼.addTarget(self, action: #selector(DANA_실행), for: .touchUpInside)
        GCASH_버튼.addTarget(self, action: #selector(GCASH_실행), for: .touchUpInside)
        RABBIT_LINE_PAY_버튼.addTarget(self, action: #selector(RABBIT_LINE_PAY_실행), for: .touchUpInside)
        TOUCHNGO_버튼.addTarget(self, action: #selector(TOUCHNGO_실행), for: .touchUpInside)
        TRUEMONEY_버튼.addTarget(self, action: #selector(TRUEMONEY_실행), for: .touchUpInside)
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
    
    @objc func ALIPAY_실행() {
      requestTossPayment(provider: "ALIPAY")
    }
    @objc func ALIPAYHK_실행() {
      requestTossPayment(provider: "ALIPAYHK")
    }
    @objc func BILLEASE_실행() {
      requestTossPayment(provider: "BILLEASE")
    }
    @objc func BOOST_실행() {
      requestTossPayment(provider: "BOOST")
    }
    @objc func BPI_실행() {
      requestTossPayment(provider: "BPI")
    }
    @objc func DANA_실행() {
      requestTossPayment(provider: "DANA")
    }
    @objc func GCASH_실행() {
      requestTossPayment(provider: "GCASH")
    }
    @objc func RABBIT_LINE_PAY_실행() {
      requestTossPayment(provider: "RABBIT_LINE_PAY")
    }
    @objc func TOUCHNGO_실행() {
      requestTossPayment(provider: "TOUCHNGO")
    }
    @objc func TRUEMONEY_실행() {
      requestTossPayment(provider: "TRUEMONEY")
    }
    
    func requestTossPayment(provider: String) {
        let tossPayments = TossPayments(clientKey: Environment.clientKey)
        tossPayments.delegate = self
        let orderId = randomString(length: 10)
        print(orderId)
        tossPayments.requestPayment(PaymentMethod.해외간편결제, ForeignEasyPayPaymentInfo(
            amount: 결제금액,
            orderId: orderId,
            orderName: "토스 티셔츠 외 2건",
            provider: provider,
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
