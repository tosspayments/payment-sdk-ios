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
    private lazy var 클라이언트키화면: TextField = {
        let textField = TextField()
        textField.title = "Client Key"
        textField.text = Environment.clientKey
        textField.textField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.addArrangedSubview(클라이언트키화면)
    }
    
    @objc func textFieldDidChanged(_ sender: Any) {
        guard let superview = (sender as? UITextField)?.superview else { return }
        guard let text = (sender as? UITextField)?.text else { return }
        switch superview {
        case 클라이언트키화면:
            Environment.clientKey = text
        default:
            break
        }
    }
}

#endif
