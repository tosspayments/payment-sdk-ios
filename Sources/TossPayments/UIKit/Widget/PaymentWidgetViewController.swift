//
//  File.swift
//  
//
//  Created by 김진규 on 2022/12/06.
//

#if canImport(UIKit)

import UIKit
import WebKit

public final class PaymentWidgetViewController: UIViewController {
    private let widget: PaymentWidget = PaymentWidget(amount: 1000, clientKey: "test_ck_OyL0qZ4G1VODAxdNWDkroWb2MQYg")
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    var isWebLoaded: Bool = false
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let button = UIButton()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        
        view.addSubview(scrollView)
        view.addSubview(button)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: button.topAnchor)
        ])
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 200),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
        scrollView.backgroundColor = .yellow
        button.backgroundColor = .blue
        button.setTitle("결제하기", for: .normal)
        button.addTarget(self, action: #selector(requestPayments), for: .touchUpInside)
        
        scrollView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .brown
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        stackView.addArrangedSubview(widget)
        widget.translatesAutoresizingMaskIntoConstraints = false
        widget.backgroundColor = .green
        
        NSLayoutConstraint.activate([
            widget.topAnchor.constraint(equalTo: view.topAnchor),
            widget.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            widget.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    @objc func requestPayments() {
        widget.requestPayments(
            info: DefaultPaymentInfo(
                amount: 1000,
                orderId: "TEST_ORDER",
                orderName: "테스트 결제"
            ),
            on: self
        )
    }
}

#endif

