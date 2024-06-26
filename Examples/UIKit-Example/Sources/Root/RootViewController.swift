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
    
    private lazy var 국가화면: TextField = {
        let textField = TextField()
        textField.title = "Country"
        textField.text = Environment.countryName
        textField.textField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        
        return textField
    }()
    
    private lazy var 통화화면: TextField = {
        let textField = TextField()
        textField.title = "Currency"
        textField.text = Environment.currencyName
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
    
    private lazy var 배리언트키화면: TextField = {
        let textField = TextField()
        textField.title = "Variant Key"
        textField.text = Environment.variantKey
        textField.textField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        
        return textField
    }()
    
    private lazy var 테스트키리셋 = Button()
    private lazy var 일반결제버튼 = Button()
    private lazy var 위젯버튼 = Button()
    private lazy var 오버레이로그화면버튼 = Button()
    private lazy var 알리페이 = Button()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.addArrangedSubview(클라이언트키화면)
        stackView.addArrangedSubview(커스터머키화면)
        stackView.addArrangedSubview(브랜드키리다이렉트화면)
        stackView.addArrangedSubview(국가화면)
        stackView.addArrangedSubview(통화화면)
        stackView.addArrangedSubview(스테이지화면)
        stackView.addArrangedSubview(배리언트키화면)
        stackView.addArrangedSubview(테스트키리셋)
        stackView.addArrangedSubview(일반결제버튼)
        stackView.addArrangedSubview(위젯버튼)
        stackView.addArrangedSubview(오버레이로그화면버튼)
        stackView.addArrangedSubview(알리페이)
        
        테스트키리셋.title = "리셋"
        일반결제버튼.title = "일반결제 테스트"
        위젯버튼.title = "위젯 테스트"
        오버레이로그화면버튼.title = "로그 토글"
        알리페이.title = "알리페이"
        
        테스트키리셋.addTarget(self, action: #selector(resetClientKey), for: .touchUpInside)
        일반결제버튼.addTarget(self, action: #selector(일반결제실행), for: .touchUpInside)
        위젯버튼.addTarget(self, action: #selector(위젯실행), for: .touchUpInside)
        오버레이로그화면버튼.addTarget(self, action: #selector(오버레이로그화면토글), for: .touchUpInside)
        알리페이.addTarget(self, action: #selector(알리페이실행), for: .touchUpInside)
    }
    
    // swiftlint:disable:next identifier_name
    @objc func 일반결제실행() {
        navigationController?.pushViewController(PaymentsViewController(), animated: true)
    }
    
    // swiftlint:disable:next identifier_name
    @objc func 위젯실행() {
        navigationController?.pushViewController(PaymentWidgetViewController(), animated: true)
    }
    
    @objc func 알리페이실행() {
        navigationController?.pushViewController(AlipayViewController(), animated: true)
    }
    
    // swiftlint:disable:next identifier_name
    @objc func 오버레이로그화면토글() {
        OverlayLogDisplayManager.shared.isShowing.toggle()
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
        case 국가화면:
            Environment.countryName = text
        case 통화화면:
            Environment.currencyName = text
        case 스테이지화면:
            Environment.stage = text
        case 배리언트키화면:
            Environment.variantKey = text
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
        국가화면.text = Environment.Constant.defaultCountryName
        Environment.currencyName = Environment.Constant.defaultCountryName
        통화화면.text = Environment.Constant.defaultCurrencyName
        Environment.currencyName = Environment.Constant.defaultCurrencyName
        스테이지화면.text = Environment.Constant.defaultStage
        Environment.stage = Environment.Constant.defaultStage
        배리언트키화면.text = Environment.Constant.defaultVariantKey
        Environment.variantKey = Environment.Constant.defaultVariantKey
    }
}
