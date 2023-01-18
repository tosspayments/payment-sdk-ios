//
//  TextField.swift
//  UIKitExample
//
//  Created by 김진규 on 2023/01/17.
//  Copyright © 2023 TossPayments, Inc. All rights reserved.
//

import UIKit

final class TextField: UIView {
    private let label = UILabel()
    public let textField = UITextField()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    var title: String = "ddd" {
        didSet {
            label.text = title
        }
    }
    
    var text: String = "" {
        didSet {
            textField.text = text
        }
    }
    
    private func setup() {
        
        label.text = text
        textField.adjustsFontSizeToFitWidth = true
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always

        translatesAutoresizingMaskIntoConstraints = false

        addSubview(label)
        addSubview(textField)
        label.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
