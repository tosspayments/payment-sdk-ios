//
//  Button.swift
//  UIKitExample
//
//  Created by 김진규 on 2023/01/17.
//  Copyright © 2023 TossPayments, Inc. All rights reserved.
//

import UIKit

final class Button: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    var title: String = "" {
        didSet {
            setTitle(title, for: .normal)
        }
    }
    
    private func setup() {
        layer.cornerRadius = 8
        backgroundColor = .systemBlue
    }
}
