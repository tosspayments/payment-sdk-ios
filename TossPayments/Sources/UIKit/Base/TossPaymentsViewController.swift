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
        let configuration = WKWebViewConfiguration()
        configuration.userContentController.add(SuccessHandler(self), name: ScriptName.success.rawValue)
        configuration.userContentController.add(ErrorHandler(error), name: ScriptName.error.rawValue)
        let webView = WKWebView(frame: .zero, configuration: configuration)
        return webView
    }()
    
    var success: ((String) -> Void)?
    var error: ((TossPaymentsResult.Fail) -> Void)?
    private let service: PaymentServiceProtocol
    private var htmlString: String?
    
    init(service: PaymentServiceProtocol) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
        webView.navigationDelegate = service
        webView.uiDelegate = self
#if DEBUG && swift(>=5.8)
        if #available(iOS 16.4, *) {
            webView.isInspectable = true
        }
#endif
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        self.presentationController?.delegate = self
        
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        loadTossPaymentsJavscript()
    }
    
    private func loadTossPaymentsJavscript() {
        // loadHTMLString 이 history 가 쌓이지 않는 현상이 있어서 hacky 한 방법으로 해결
        self.webView.load(URLRequest(url: URL(string: "about:blank")!))
        DispatchQueue.main.async {
            self.webView.loadHTMLString(self.service.htmlString, baseURL: self.service.baseURL)
        }
    }
}

extension TossPaymentsViewController: UIAdaptivePresentationControllerDelegate {
    
    @available(iOS 13.0, *)
    public func presentationControllerDidDismiss(
      _ presentationController: UIPresentationController)
    {
        var components = URLComponents(string: WebConstants.failURL)
        components?.queryItems = [
            URLQueryItem(name: "code", value: "PAY_PROCESS_CANCELED"),
            URLQueryItem(name: "message", value: "사용자가 결제를 취소하였습니다"),
            URLQueryItem(name: "orderId", value: self.service.orderId),
        ]
        guard let failURL = components?.url else { return }
        self.service.failURLHandler?(failURL)
    }
}

#endif
