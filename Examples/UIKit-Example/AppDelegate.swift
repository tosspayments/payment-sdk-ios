//
//  AppDelegate.swift
//  UIKitExample
//
//  Created by 김진규 on 2022/09/27.
//

#if canImport(UIKit)
import UIKit

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
        return true
    }
}

#endif
