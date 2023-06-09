//
//  RootViewController.swift
//  UIKitExample
//
//  Created by 김진규 on 2022/12/21.
//  Copyright © 2022 TossPayments, Inc. All rights reserved.
//

import UIKit

final class RootViewController: ViewController {
    private lazy var 클라이언트키화면: TextField = {
        let textField = TextField()
        textField.title = "Client Key"
        textField.text = Environment.clientKey
        textField.textField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        
        return textField
    }()
    
    private lazy var 커스터머키화면: TextField = {
        let textField = TextField()
        textField.title = "Customer Key"
        textField.text = Environment.customerKey
        textField.textField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        
        return textField
    }()
    
    private lazy var 브랜드키리다이렉트화면: TextField = {
        let textField = TextField()
        textField.title = "Redirect URL"
        textField.text = Environment.brandPayRedirectURL
        textField.textField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        
        return textField
    }()
    
    private lazy var 스테이지화면: TextField = {
        let textField = TextField()
        textField.title = "Stage"
        textField.text = Environment.stage
        textField.textField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        
        return textField
    }()
    
    private lazy var 테스트키리셋 = Button()
    private lazy var 일반결제버튼 = Button()
    private lazy var 위젯버튼 = Button()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.addArrangedSubview(클라이언트키화면)
        stackView.addArrangedSubview(커스터머키화면)
        stackView.addArrangedSubview(브랜드키리다이렉트화면)
        stackView.addArrangedSubview(스테이지화면)
        stackView.addArrangedSubview(테스트키리셋)
        stackView.addArrangedSubview(일반결제버튼)
        stackView.addArrangedSubview(위젯버튼)
        
        테스트키리셋.title = "리셋"
        일반결제버튼.title = "일반결제 테스트"
        위젯버튼.title = "위젯 테스트"
        
        테스트키리셋.addTarget(self, action: #selector(resetClientKey), for: .touchUpInside)
        일반결제버튼.addTarget(self, action: #selector(일반결제실행), for: .touchUpInside)
        위젯버튼.addTarget(self, action: #selector(위젯실행), for: .touchUpInside)
    }
    
    // swiftlint:disable:next identifier_name
    @objc func 일반결제실행() {
        navigationController?.pushViewController(PaymentsViewController(), animated: true)
    }
    
    // swiftlint:disable:next identifier_name
    @objc func 위젯실행() {
        navigationController?.pushViewController(PaymentWidgetViewController(), animated: true)
    }

    @objc func textFieldDidChanged(_ sender: Any) {
        guard let superview = (sender as? UITextField)?.superview else { return }
        guard let text = (sender as? UITextField)?.text else { return }
        switch superview {
        case 클라이언트키화면:
            Environment.clientKey = text
        case 커스터머키화면:
            Environment.customerKey = text
        case 브랜드키리다이렉트화면:
            Environment.brandPayRedirectURL = text
        case 스테이지화면:
            Environment.stage = text
        default:
            break
        }
    }
    
    @objc func resetClientKey() {
        클라이언트키화면.text = Environment.Constant.defaultClientKey
        Environment.clientKey = Environment.Constant.defaultClientKey
        커스터머키화면.text = Environment.Constant.defaultCustomerKey
        Environment.customerKey = Environment.Constant.defaultCustomerKey
        브랜드키리다이렉트화면.text = Environment.Constant.defaultBrandpayRedirectURL
        Environment.brandPayRedirectURL = Environment.Constant.defaultBrandpayRedirectURL
        스테이지화면.text = Environment.Constant.defaultStage
        Environment.stage = Environment.Constant.defaultStage
        
    }
}
