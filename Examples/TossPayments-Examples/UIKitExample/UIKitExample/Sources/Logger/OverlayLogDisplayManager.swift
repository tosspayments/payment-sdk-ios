//
//  OverlayLogViewController.swift
//  UIKitExample
//
//  Created by 김진규 on 2023/06/20.
//  Copyright © 2023 TossPayments, Inc. All rights reserved.
//

import UIKit

class OverlayLogDisplayManager {
    
    var window: UIWindow?
    var viewController: OverlayLogViewController?
    static let shared = OverlayLogDisplayManager()
    func show(on window: UIWindow) {
        
        let overlayWindow = UIWindow(frame: CGRect(x: 0, y: 80, width: window.frame.width, height: 200))
        overlayWindow.windowLevel = window.windowLevel + 1
        overlayWindow.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        let viewController = OverlayLogViewController()
        self.viewController = viewController
        overlayWindow.rootViewController = viewController
        overlayWindow.makeKeyAndVisible() // 오버레이 윈도우를 화면에 표시합니다.
        overlayWindow.isUserInteractionEnabled = false
        self.window = overlayWindow
    }
    
    func log(_ text: String) {
        guard let textView = viewController?.textView else { return }
        textView.text = (textView.text ?? "") + "\n" + text
        // 스크롤을 가장 아래로 이동
        let bottomOffset = CGPoint(x: 0, y: textView.contentSize.height - textView.bounds.size.height)
        textView.setContentOffset(bottomOffset, animated: false)
    }
}

class OverlayLogViewController: UIViewController {
    
    var textView: UITextView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textView = UITextView(frame: view.bounds)
        view.addSubview(textView)
        
        self.textView = textView
        textView.font = UIFont(name: textView.font?.fontName ?? "", size: 8)
        textView.backgroundColor = .clear // 오버레이 뷰 배경색 설정
        textView.isEditable = false
        textView.isScrollEnabled = true
    }
}
