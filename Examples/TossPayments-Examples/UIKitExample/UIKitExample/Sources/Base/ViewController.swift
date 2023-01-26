//
//  ViewController.swift
//  UIKitExample
//
//  Created by 김진규 on 2023/01/17.
//  Copyright © 2023 TossPayments, Inc. All rights reserved.
//

import UIKit

open class ViewController: UIViewController {
    public lazy var scrollView = UIScrollView()
    public lazy var stackView = UIStackView()
    
    public var scrollViewBottomAnchorConstraint: NSLayoutConstraint?
    open override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.alwaysBounceVertical = true
        
        stackView.spacing = 24
        stackView.axis = .vertical
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let scrollViewBottomAnchorConstraint = scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollViewBottomAnchorConstraint,
            scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -48),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        self.scrollViewBottomAnchorConstraint = scrollViewBottomAnchorConstraint
    }
}
