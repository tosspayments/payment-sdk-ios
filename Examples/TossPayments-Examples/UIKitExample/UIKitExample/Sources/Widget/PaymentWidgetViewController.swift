//
//  File.swift
//  
//
//  Created by 김진규 on 2022/12/06.
//

#if canImport(UIKit)

import UIKit
import WebKit
import TossPayments

public final class PaymentWidgetViewController: UIViewController {
    enum Constant {
        static let defaultAmount: Int64 = 1000
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    var isWebLoaded: Bool = false
    
    private lazy var scrollView = UIScrollView()
    private lazy var stackView = UIStackView()
    
    private lazy var 결제금액라벨 = UILabel()
    private lazy var 결제금액입력 = UITextField()
    
    private lazy var widget: PaymentWidget = PaymentWidget(amount: Constant.defaultAmount, clientKey: Environment.clientKey)
    private lazy var 빈화면 = UIView()
    
    private lazy var button = UIButton()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "위젯"
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        view.addSubview(scrollView)
        view.addSubview(button)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            scrollView.bottomAnchor.constraint(equalTo: button.topAnchor)
        ])
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 60),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        ])
        button.backgroundColor = .systemBlue
        button.setTitle("결제하기", for: .normal)
        button.addTarget(self, action: #selector(requestPayments), for: .touchUpInside)
        
        scrollView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -48),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        stackView.addArrangedSubview(결제금액라벨)
        stackView.addArrangedSubview(결제금액입력)
        
        결제금액라벨.text = "amount (원)"
        
        결제금액입력.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        결제금액입력.keyboardType = .numberPad
        결제금액입력.borderStyle = .roundedRect
        결제금액입력.text = "\(Constant.defaultAmount)"
        
        widget.amount = Constant.defaultAmount
        
        
        stackView.addArrangedSubview(widget)
        widget.delegate = self
        widget.widgetUIDelegate = self
        
        stackView.addArrangedSubview(빈화면)
        NSLayoutConstraint.activate([
            빈화면.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            빈화면.heightAnchor.constraint(equalToConstant: 80)
        ])
        빈화면.backgroundColor = .lightGray
    }
    
    @objc func requestPayments() {
        widget.requestPayments(
            info: DefaultPaymentInfo(
                amount: widget.amount,
                orderId: "TEST_ORDER",
                orderName: "테스트 결제"
            ),
            on: self
        )
    }
}

extension PaymentWidgetViewController {
    @objc func textFieldDidChanged(_ sender: Any) {
        if let amountString = (sender as? UITextField)?.text,
           let amount = Int64(amountString) {
            widget.amount = amount
        }
    }
}

extension PaymentWidgetViewController: TossPaymentsDelegate {
    public func didSucceedRequestPayments(paymentKey: String, orderId: String, amount: Int64) {
        print("didSucceedRequestPayments paymentKey: \(paymentKey)")
        print("didSucceedRequestPayments paymentKey: \(orderId)")
        print("didSucceedRequestPayments paymentKey: \(amount)")
    }
    
    public func didFailRequestPayments(errorCode: String, errorMessage: String, orderId: String) {
        print("didFailRequestPayments paymentKey: \(errorCode)")
        print("didFailRequestPayments paymentKey: \(errorMessage)")
        print("didFailRequestPayments paymentKey: \(orderId)")
    }
}

extension PaymentWidgetViewController: TossPaymentsWidgetUIDelegate {
    public func didUpdateHeight(_ widget: PaymentWidget, height: CGFloat) {
        print("didUpdateHeight \(height)")
    }
    
    
}

#endif

