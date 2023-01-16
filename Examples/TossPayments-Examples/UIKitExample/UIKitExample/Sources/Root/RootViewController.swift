//
//  RootViewController.swift
//  UIKitExample
//
//  Created by 김진규 on 2022/12/21.
//  Copyright © 2022 TossPayments, Inc. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {
    private lazy var scrollView = UIScrollView()
    private lazy var stackView = UIStackView()
    
    private lazy var 테스트키화면: UIView = {
        
        let 테스트키라벨 = UILabel()
        테스트키라벨.text = "Client Key"
        
        let 테스트키텍스트필드 = UITextField()
        let 테스트키리셋 = UIButton()
        
        테스트키텍스트필드.borderStyle = .roundedRect
        테스트키텍스트필드.clearButtonMode = .always
        
        let container = UIView()
        container.addSubview(테스트키라벨)
        container.addSubview(테스트키텍스트필드)
        container.addSubview(테스트키리셋)
        테스트키라벨.translatesAutoresizingMaskIntoConstraints = false
        테스트키텍스트필드.translatesAutoresizingMaskIntoConstraints = false
        테스트키리셋.translatesAutoresizingMaskIntoConstraints = false
        테스트키텍스트필드.text = Environment.clientKey
        테스트키텍스트필드.adjustsFontSizeToFitWidth = true
        NSLayoutConstraint.activate([
            테스트키라벨.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            테스트키라벨.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            테스트키라벨.topAnchor.constraint(equalTo: container.topAnchor),
            테스트키텍스트필드.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            테스트키텍스트필드.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            테스트키텍스트필드.topAnchor.constraint(equalTo: 테스트키라벨.bottomAnchor, constant: 8),
            테스트키리셋.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            테스트키리셋.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            테스트키리셋.topAnchor.constraint(equalTo: 테스트키텍스트필드.bottomAnchor, constant: 8),
            
            테스트키리셋.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        테스트키텍스트필드.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        테스트키리셋.addTarget(self, action: #selector(resetClientKey), for: .touchUpInside)
        
        테스트키리셋.layer.cornerRadius = 8
        테스트키리셋.backgroundColor = .systemBlue
        테스트키리셋.setTitle("ClientKey 리셋", for: .normal)
        
        self.테스트키텍스트필드 = 테스트키텍스트필드
        
        return container
    }()
    private lazy var 일반결제버튼 = UIButton()
    private lazy var 위젯버튼 = UIButton()
    
    private var 테스트키텍스트필드: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
        ])
        
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 24
        stackView.axis = .vertical
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -48)
        ])
        
        stackView.addArrangedSubview(테스트키화면)
        stackView.addArrangedSubview(일반결제버튼)
        stackView.addArrangedSubview(위젯버튼)
        
        일반결제버튼.setTitle("일반결제 테스트", for: .normal)
        위젯버튼.setTitle("위젯 테스트", for: .normal)
        
        일반결제버튼.layer.cornerRadius = 8
        일반결제버튼.backgroundColor = .systemBlue
        위젯버튼.layer.cornerRadius = 8
        위젯버튼.backgroundColor = .systemBlue
        
        일반결제버튼.addTarget(self, action: #selector(일반결제실행), for: .touchUpInside)
        위젯버튼.addTarget(self, action: #selector(위젯실행), for: .touchUpInside)
    }
    
    @objc func 일반결제실행() {
        navigationController?.pushViewController(ViewController(), animated: true)
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
        테스트키텍스트필드.text = Environment.Constant.defaultKey
        Environment.clientKey = Environment.Constant.defaultKey
    }
}
