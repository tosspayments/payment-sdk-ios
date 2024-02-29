//
//  File.swift
//  
//
//  Created by 김진규 on 2022/12/21.
//

import UIKit

extension UIWindow {
    @objc var visibleViewController: UIViewController? {
        var visibleViewController = self.rootViewController
        while let presentedViewController = visibleViewController?.presentedViewController {
            visibleViewController = presentedViewController
        }
        
        while let visibleView = visibleViewController, visibleView.isBeingDismissed,
            let presentingViewController = visibleView.presentingViewController {
            visibleViewController = presentingViewController
        }

        return visibleViewController
    }
    
    /*! @brief 현재 self(UIWindow) 보이는 가장 최상위의 viewController 중,
     UITabBarController 혹은 UINavigationController 가 아닌 viewController 를 리턴한다.
     @description self.visibleViewController 가 UITabBarController 혹은 UINavigationController 일 경우,
     .selectedViewController, .topViewController 등을 이용해서
     의미있는 viewController 를 찾아준다.
     */
    @objc var visibleContentViewController: UIViewController? {
        var visibleContentViewController = self.visibleViewController

        // 그게 UITabBarController 면...
        // selectedViewController 로 지정해준다.
        if let tabBarController = visibleContentViewController as? UITabBarController {
            visibleContentViewController = tabBarController.selectedViewController
        }

        // 그게 UINavigationController 면...
        // visibleController 로 지정해준다.
        if let navigationController = visibleContentViewController as? UINavigationController {
            visibleContentViewController = navigationController.visibleViewController
        }

        return visibleContentViewController
    }
}
