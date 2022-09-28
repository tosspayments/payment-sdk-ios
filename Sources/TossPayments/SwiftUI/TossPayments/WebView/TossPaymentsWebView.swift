//
//  TossPaymentsWebView.swift
//  
//
//  Created by 김진규 on 2022/09/27.
//

#if canImport(SwiftUI) && canImport(UIKit)
import SwiftUI
import UIKit
import WebKit

@available(iOS 14.0, *)
struct TossPaymentsWebView: UIViewRepresentable {
    private let service: TossPaymentsService
    init(service: TossPaymentsService) {
        self.service = service
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = service
        webView.loadHTMLString(service.htmlString, baseURL: URL(string: "https://tosspayments.com"))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}

#endif
