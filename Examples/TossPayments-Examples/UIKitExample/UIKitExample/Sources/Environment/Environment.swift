//
//  File.swift
//  
//
//  Created by 김진규 on 2023/01/16.
//

import Foundation

public final class Environment {
    public enum Constant {
        public static let appScheme: String? = {
            guard let infoDictionary = Bundle.main.infoDictionary,
                  let bundleURLTypes = infoDictionary["CFBundleURLTypes"] as? [[String: Any]],
                  let firstBundleURLType = bundleURLTypes.first,
                  let bundleURLSchemes = firstBundleURLType["CFBundleURLSchemes"] as? [String],
                  let scheme = bundleURLSchemes.first else {
                return nil
            }
            return scheme + "://"
        }()

        static let defaultClientKey = "live_ck_JQbgMGZzorzj0ZnKbOjrl5E1em4d"
        static let defaultCustomerKey = "TOSSPAYMENTS"
        static let defaultBrandpayRedirectURL: String = {
            if let infoDictionary = Bundle.main.infoDictionary,
               let brandpayRedirectURL = infoDictionary["BRANDPAY_REDIRECT_URL"] as? String,
               !brandPayRedirectURL.isEmpty {
                return brandpayRedirectURL
            }
            return """
            https://tosspayments.com/redierct
            """
        }()
        static let defaultStage = "beta"
        static let defaultVariantKey = "CardOnly"
    }
    
    static var clientKey: String = UserDefaults.standard.string(forKey: "TossPayments.ClientKey")
    ?? Constant.defaultClientKey {
        didSet {
            UserDefaults.standard.set(clientKey, forKey: "TossPayments.ClientKey")
        }
    }
    
    static var customerKey: String = "TOSSPAYMENTS"
    
    /// 현재 redirectURL의 미구현으로 브랜드페이는 정상적으로 동작하지 않고 있다.
    static var brandPayRedirectURL: String = "https://tosspayments.com/api/brandpay/v1/callback-auth"
}
