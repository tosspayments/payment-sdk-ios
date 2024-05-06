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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.addArrangedSubview(클라이언트키화면)
        stackView.addArrangedSubview(금액금액화면)
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
}

#endif
