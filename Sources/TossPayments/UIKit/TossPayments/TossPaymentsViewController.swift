//
//  TossPaymentsViewController.swift
//  
//
//  Created by 김진규 on 2022/09/27.
//

#if canImport(UIKit)

import UIKit
import WebKit

final class TossPaymentsViewController: UIViewController {
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        

        return webView
    }()
    
    private let service: PaymentServiceProtocol
    private var htmlString: String?
    
    init(service: PaymentServiceProtocol) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
        webView.navigationDelegate = service
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        loadTossPaymentsJavscript()
    }
    
    private func loadTossPaymentsJavscript() {
        print(self.service.htmlString)
        DispatchQueue.main.async {
            self.webView.loadHTMLString(self.service.htmlString, baseURL: URL(string: "https://tosspayments.com/"))
        }
    }
}

#endif
