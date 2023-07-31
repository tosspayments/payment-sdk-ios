//
//  BrowserPopupWindowController.swift
//
//
//  Created by https://github.com/MussaCharles on 2023/04/19.
//

import UIKit
import WebKit

/*
 A view controller which wraps WKWebView which is then being used 
 as a host when browser `window.open(<url>)` method is triggered.
 This happens when buttons/webView UI component onClick events
trigger a `window.open(<url>)` javascript method. For example when 
user tap 신용카드 무이자 할부 안내 등등 component on Toss Widget such action 
seems to be triggered. To see how this class is used have a look on 
`PaymentWidget+WKUIDelegate.swift` file.
 */
final class BrowserPopupWindowController: UIViewController {
    
    // MARK: - Properties
    private let popupWebView: WKWebView
    
    // MARK: - Life Cycle
    required init(popupWebView: WKWebView) {
        self.popupWebView = popupWebView
        super.init(nibName: nil, bundle: nil)
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        // Re-assign UI delegate to this controler so that we can handle broswers window.close() event.
        popupWebView.uiDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCloseRightNavigationBarButtonItem()
        autoLayout()
    }
    
    // MARK: - Helpers
    private func autoLayout() {
        self.view.addSubview(popupWebView)
        self.popupWebView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            popupWebView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            popupWebView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            popupWebView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            popupWebView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        ])
    }
    
    func addCloseRightNavigationBarButtonItem() {
        if #available(iOS 13.0, *) {
            navigationItem.rightBarButtonItem 
            = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(handleCloseAction))
        } else {
            navigationItem.rightBarButtonItem 
            = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCloseAction))
        }
    }
    
    @objc private func handleCloseAction() {
        DispatchQueue.main.async { 
            if let navigationController = self.navigationController {
                if navigationController.viewControllers.count > 1 {
                    navigationController.popViewController(animated: true)
                } else if self.presentingViewController != nil {
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}

// MARK: - WKUIDelegate

extension BrowserPopupWindowController: WKUIDelegate {
    
    func webViewDidClose(_ webView: WKWebView) {
        // Detect broswer window close event and dismiss this page accordingly.
        guard webView == popupWebView else {return}
        handleCloseAction()
    }
}
