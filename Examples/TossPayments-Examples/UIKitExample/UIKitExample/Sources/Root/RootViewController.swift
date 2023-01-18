//
//  RootViewController.swift
//  UIKitExample
//
//  Created by 김진규 on 2022/12/21.
//  Copyright © 2022 TossPayments, Inc. All rights reserved.
//

import UIKit

final class RootViewController: ViewController {
    private lazy var 테스트키화면: TextField = {
        let textField = TextField()
        textField.title = "Client Key"
        textField.text = Environment.clientKey
        textField.textField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        
        return textField
    }()
    
    private lazy var 테스트키리셋 = Button()
    private lazy var 일반결제버튼 = Button()
    private lazy var 위젯버튼 = Button()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.addArrangedSubview(테스트키화면)
        stackView.addArrangedSubview(테스트키리셋)
        stackView.addArrangedSubview(일반결제버튼)
        stackView.addArrangedSubview(위젯버튼)
        
        테스트키리셋.title = "ClientKey 리셋"
        일반결제버튼.title = "일반결제 테스트"
        위젯버튼.title = "위젯 테스트"
        
        테스트키리셋.addTarget(self, action: #selector(resetClientKey), for: .touchUpInside)
        일반결제버튼.addTarget(self, action: #selector(일반결제실행), for: .touchUpInside)
        위젯버튼.addTarget(self, action: #selector(위젯실행), for: .touchUpInside)
    }
    
    @objc func 일반결제실행() {
        navigationController?.pushViewController(PaymentsViewController(), animated: true)
    }
    
    @objc func 위젯실행() {
        navigationController?.pushViewController(PaymentWidgetViewController(), animated: true)
    }

    @objc func textFieldDidChanged(_ sender: Any) {
        if let clientKey = (sender as? UITextField)?.text {
            Environment.clientKey = clientKey
        }
    }
    
    @objc func resetClientKey() {
        테스트키화면.text = Environment.Constant.defaultKey
        Environment.clientKey = Environment.Constant.defaultKey
    }
}
