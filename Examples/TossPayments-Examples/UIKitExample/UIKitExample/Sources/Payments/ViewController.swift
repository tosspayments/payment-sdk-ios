//
//  ViewController.swift
//  UIKitExample
//
//  Created by 김진규 on 2022/09/27.
//

#if canImport(UIKit)
import UIKit
import TossPayments

private enum Constants {
    static let clientKey: String = Environment.clientKey
    static let 테스트결제정보: PaymentInfo = DefaultPaymentInfo(
        amount: 1000,
        orderId: "9lD0azJWxjBY0KOIumGzH",
        orderName: "토스 티셔츠 외 2건",
        customerName: "박토스"
    )
}

class ViewController: UIViewController {
    var 입력한결제수단: PaymentMethod? {
        didSet {
            guard let 입력한결제수단 = 입력한결제수단 else { return}
            let 입력한결제수단레이블텍스트: String = "입력한 결제수단: \(입력한결제수단.rawValue)"
            viewHolder.입력한결제수단레이블.text = 입력한결제수단레이블텍스트
        }
    }
    var 입력한결제정보: PaymentInfo? {
        didSet {
            guard let 입력한결제정보 = 입력한결제정보 else { return }
            let 입력한결제정보레이블텍스트: String = """
                입력한 결제정보:
                \(입력한결제정보.orderedInfo)
                """
            viewHolder.입력한결제정보레이블.text = 입력한결제정보레이블텍스트 
        }
    }
    
    
    private let viewHolder = ViewHolder()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "TossPayments 테스트 페이지"
        viewHolder.installViews(at: view)
        
        viewHolder.pickerView.dataSource = self
        viewHolder.pickerView.delegate = self
        
        viewHolder.button.addTarget(self, action: #selector(didTabActionButton(_:)), for: .touchUpInside)
        
        입력한결제수단 = PaymentMethod.allCases.first
        입력한결제정보 = Constants.테스트결제정보
    }

    @objc func didTabActionButton(_ sender: Any) {
        requestTossPayments()
    }
    
    func requestTossPayments() {
        guard let 입력한결제수단 = 입력한결제수단,
              !입력한결제수단.rawValue.isEmpty else {
            showAlertEmpty결제수단()
            return
        }
        guard let 입력한결제정보 = 입력한결제정보 else {
            return
        }
        
        let 결제수단 = 입력한결제수단
        let 결제정보 = 입력한결제정보
        
        let tossPayments = TossPayments(clientKey: Constants.clientKey)
        tossPayments.delegate = self
        tossPayments.requestPayment(결제수단, 결제정보, on: self)
    }
}

#endif
