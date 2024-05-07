//
//  AppDelegate.swift
//  UIKitExample
//
//  Created by 김진규 on 2022/09/27.
//

#if canImport(UIKit)
import UIKit
import TossPayments

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow()
        window.rootViewController = UINavigationController(rootViewController: RootViewController())
        window.makeKeyAndVisible()
        self.window = window
        
        OverlayLogDisplayManager.shared.start(on: window)
        
        return true
    }
}

extension AppDelegate {
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        Logger.debug("open URL : " + url.absoluteString)
        var scheme = url.scheme
        var host = url.host
        var relativePath = url.relativePath
        var path = url.path
        var query = url.query
        if url.scheme == "tosspaymentexample" {
            if host == "pending" {
                let title = "TossPayments 요청이 보류되었습니다."
                let message = """
                query: \(url.query)
                """
                showAlert(title: title, message: message)
                return true
            }
        }

        return true
    }
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        alertController.addAction(
            UIAlertAction(
                title: "클립보드에 복사하기",
                style: .destructive,
                handler: { _ in
                    UIPasteboard.general.string = message
                }
            )
        )
        self.window?.rootViewController?.dismiss(animated: true)
        alertController.addAction(UIAlertAction(title: "확인", style: .default))
        self.window?.rootViewController?.present(alertController, animated: true)
    }

}

#endif
