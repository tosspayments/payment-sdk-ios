//
//  ResultViewController.swift
//  UIKitExample
//
//  Created by 김진규 on 2023/01/17.
//  Copyright © 2023 TossPayments, Inc. All rights reserved.
//

import Foundation
import UIKit

struct ResultViewModel {
    typealias Result = (title: String, text: String)
    let result1: Result
    let result2: Result
    let result3: Result
    
    var debugString: String {
        """
        \(result1.title): \(result1.text)
        \(result2.title): \(result2.text)
        \(result3.title): \(result3.text)
        """
    }
}

final class ResultViewController: ViewController {
    lazy var field1 = TextField()
    lazy var field2 = TextField()
    lazy var field3 = TextField()
    lazy var copyButton = Button()
    
    let viewModel: ResultViewModel
    init(viewModel: ResultViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        title = "결과화면"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.addArrangedSubview(field1)
        stackView.addArrangedSubview(field2)
        stackView.addArrangedSubview(field3)
        stackView.addArrangedSubview(copyButton)
        
        field1.title = viewModel.result1.title
        field1.text = viewModel.result1.text
        field2.title = viewModel.result2.title
        field2.text = viewModel.result2.text
        field3.title = viewModel.result3.title
        field3.text = viewModel.result3.text
        
        copyButton.title = "복사하기"
        copyButton.addTarget(self, action: #selector(copyPasteBoard), for: .touchUpInside)
    }
    
    @objc func copyPasteBoard() {
        UIPasteboard.general.string = viewModel.debugString
    }
}
