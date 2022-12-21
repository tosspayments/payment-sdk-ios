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
    private let widget: PaymentWidget = PaymentWidget(clientKey: "test_ck_OyL0qZ4G1VODAxdNWDkroWb2MQYg")
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    var isWebLoaded: Bool = false
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        view.addSubview(widget)
        widget.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widget.topAnchor.constraint(equalTo: view.topAnchor),
            widget.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            widget.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            widget.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    func requestPayments() {
        widget.requestPayments(
            info: DefaultPaymentInfo(
                amount: 1000,
                orderId: "TEST_ORDER",
                orderName: "테스트 결제"
            )
        )
    }
}

#endif

