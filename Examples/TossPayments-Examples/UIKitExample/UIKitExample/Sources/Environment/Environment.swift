//
//  File.swift
//  
//
//  Created by 김진규 on 2023/01/16.
//

import Foundation

final class Environment {
    enum Constant {
        static let defaultKey = "test_ck_OyL0qZ4G1VODAxdNWDkroWb2MQYg"
    }
    
    static var clientKey: String = UserDefaults.standard.string(forKey: "TossPayments.ClientKey")
    ?? Constant.defaultKey {
        didSet {
            UserDefaults.standard.set(clientKey, forKey: "TossPayments.ClientKey")
        }
    }
    
    static var customerKey: String = "TOSSPAYMENTS"
    
    /// 현재 redirectURL의 미구현으로 브랜드페이는 정상적으로 동작하지 않고 있다.
    static var brandPayRedirectURL: String = "https://tosspayments.com/api/brandpay/v1/callback-auth"
}
