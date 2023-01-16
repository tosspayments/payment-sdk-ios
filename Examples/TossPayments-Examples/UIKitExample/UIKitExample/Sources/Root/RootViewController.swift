//
//  RootViewController.swift
//  UIKitExample
//
//  Created by 김진규 on 2022/12/21.
//  Copyright © 2022 TossPayments, Inc. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {
    private lazy var stackView = UIStackView()
    
    private lazy var 테스트키텍스트필드 = UITextField()
    private lazy var 페이먼츠버튼 = UIButton()
    private lazy var 위젯버튼 = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.axis = .vertical
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        stackView.addArrangedSubview(테스트키텍스트필드)
        stackView.addArrangedSubview(페이먼츠버튼)
        stackView.addArrangedSubview(위젯버튼)
        
        테스트키텍스트필드.borderStyle = .roundedRect
        테스트키텍스트필드.clearButtonMode = .always
        페이먼츠버튼.setTitle("일반결제 테스트", for: .normal)
        위젯버튼.setTitle("위젯 테스트", for: .normal)
        
        페이먼츠버튼.setTitleColor(.black, for: .normal)
        위젯버튼.setTitleColor(.black, for: .normal)
        
        위젯버튼.addTarget(self, action: #selector(위젯실행), for: .touchUpInside)
    }
    
    @objc func 위젯실행() {
        navigationController?.pushViewController(PaymentWidgetViewController(), animated: true)
    }
}
